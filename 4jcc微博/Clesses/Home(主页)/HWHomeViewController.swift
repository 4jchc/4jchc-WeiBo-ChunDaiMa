
//  HWHomeViewController.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/2.
//  Copyright © 2015年 sijichcai. All rights reserved.


import UIKit

class HWHomeViewController: UITableViewController,HMDropdownMenuDelegate {

    /**
    *  微博数组（里面放的都是HWStatusFrame模型，一个HWStatusFrame对象就代表一条微博）
    *  将HWStatus模型转为HWStatusFrame模型
    *///遍历模型赋值新的模型添加到新的数组
    func stausFramesWithStatuses(statuses:NSArray) ->NSArray{
        
        let frames: NSMutableArray  = NSMutableArray()
        
        for status in statuses {
            let f: HWStatusFrame  = HWStatusFrame()
        f.status = status as? HWStatus;
        frames.addObject(f)
        }
        return frames;
    }

    
    /**
    *  微博数组（里面放的都是HWStatus模型，一个HWStatus对象就代表一条微博）
    */
    
    lazy var statusFrames:NSMutableArray? = {
        
        var statuse = NSMutableArray()
        
        return statuse
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航栏内容
        self.setupNav()
        
        // 获得用户信息（昵称）
        self.setupUserInfo()
        
        // 集成下拉刷新控件
       self.setupDownRefresh()
        
        // 集成上拉刷新控件
        self.setupUpRefresh()
        
        //MARK: 获得未读数
        let timer: NSTimer  = NSTimer.scheduledTimerWithTimeInterval(120, target: self, selector: "setupUnreadCount", userInfo: nil, repeats:true)
        // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        
    }

    /**
    *  获得未读数
    */
    func setupUnreadCount() {

        // 2.拼接请求参数
        let account:HMAccountModel = HMAccountTool.loadAccount()!
        let params:NSMutableDictionary = NSMutableDictionary()
        
        params["access_token"] = account.access_token;
        params["uid"] = account.uid
        
        
       
        HWHttpTool.get("https://rm.api.weibo.com/2/remind/unread_count.json", params: params as NSDictionary, success: { (responseObject) -> Void in
            
            
           //MARK:  设置提醒数字(微博的未读数)
            let status = (responseObject["status"])!!.description as NSString
           /// print("*****\(status)")
            if status.isEqualToString("0") {// 如果是0，得清空数字
                
                self.tabBarItem.badgeValue = nil;
                UIApplication.sharedApplication().applicationIconBadgeNumber = 0
                print("**UIApplication.sharedApplication().applicationIconBadgeNumber***\(UIApplication.sharedApplication().applicationIconBadgeNumber)")
            }else{//非0情况
                
                self.tabBarItem.badgeValue = status as String
                
                UIApplication.sharedApplication().applicationIconBadgeNumber = status.integerValue
                print("**UIApplication.sharedApplication().applicationIconBadgeNumber***\(UIApplication.sharedApplication().applicationIconBadgeNumber)")
        }

            }) { ( error) -> Void in
                print("*****请求失败")
               
        }

}
    

    //MARK: - 集成上拉刷新控件
    func setupUpRefresh(){
        
//        let footer = HWLoadMoreFooter.footer()
//
//        footer.hidden = true
//        
//        self.tableView.tableFooterView = footer;
        

        self.tableView.mj_footer = MJRefreshAutoFooter(refreshingBlock: { () -> Void in
            self.loadMoreStatus()
        })
      
        
        //[self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    }
    

    /**
    *  集成下拉刷新控件
    */
    func setupDownRefresh(){
        
//        // 1.添加刷新控件
//        let control:UIRefreshControl = UIRefreshControl()
//      
//        // 只有用户通过手动下拉刷新，才会触发UIControlEventValueChanged事件
//        control.addTarget(self, action: "loadNewStatus:", forControlEvents: UIControlEvents.ValueChanged)
//        
//        self.tableView.addSubview(control)
//        
//        // 2.马上进入刷新状态(仅仅是显示刷新状态，并不会触发UIControlEventValueChanged事件)
//            
//        control.beginRefreshing()
//        
//        // 3.马上加载数据
//        self.loadNewStatus(control)
        
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.loadNewStatus()
        })
        self.tableView.mj_header.beginRefreshing()
        
        //self.tableView.tableHeaderView = MJRefreshNormalHeader
        
        
        
        
        
    }
    
    
    /**
    *  UIRefreshControl进入刷新状态：加载最新的数据
    */ //func loadNewStatus(control:UIRefreshControl){
        
    func loadNewStatus(){
        
        
        // https://api.weibo.com/2/users/show.json
        // access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
        // uid	false	int64	需要查询的用户ID。
        // 1.请求管理者
        //let mgr:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        
        // 2.拼接请求参数
        let account:HMAccountModel = HMAccountTool.loadAccount()!
        let params:NSMutableDictionary = NSMutableDictionary()
        
        params["access_token"] = account.access_token;
        params["count"] = 20
        
        // 取出最前面的微博（最新的微博，ID最大的微博）//❌ as? HWStatusFrame写成HWStatus,所以一直显示刷新20条
        let firstStatus = self.statusFrames!.firstObject as? HWStatusFrame
        if firstStatus != nil {
            // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
            
            params["since_id"] = firstStatus!.status!.idstr //firstStatus!.idstr;
        }
        
        
        //MARK: 闭包带参数
        // 定义一个block处理返回的字典数据
        let dealingResultBlock: (NSArray) -> Void = { (dictArray) in
            
            /** 将 "微博字典"数组 转为 "微博模型"数组*/
            let newStatuses = (HWStatus.objectArrayWithKeyValuesArray(dictArray as [AnyObject]) as AnyObject) //as? NSMutableArray)!
            // 将 HWStatus数组 转为 HWStatusFrame数组
            let newFrames = self.stausFramesWithStatuses(newStatuses as! NSArray)
            
            // 将最新的微博数据，添加到总数组的最前面
            let range: NSRange = NSMakeRange(0, newFrames.count);
            let set: NSIndexSet = NSIndexSet(indexesInRange: range)
            self.statusFrames!.insertObjects(newFrames as [AnyObject],atIndexes:set)
            
            // 刷新表格
            self.tableView.reloadData()
            
            // 结束刷新
            self.tableView.mj_header.endRefreshing()
            
            // 显示最新微博的数量(刚刚加载转换的数组个数)
            self.showNewStatusCount(newStatuses.count)
        }

    
        // 2.先尝试从数据库中加载微博数据
        let statuses: NSArray? = HWStatusToolSQ.statusesWithParams(params)!
        
        print("*****\(statuses!.count)")
        if (statuses!.count != 0) {
            // 数据库有缓存数据
            dealingResultBlock(statuses!)
        } else {


        // 3.发送请求
        //https://api.weibo.com/2/statuses/friends_timeline.json

        HWHttpTool.get("https://api.weibo.com/2/statuses/friends_timeline.json", params: params as NSDictionary, success: { (responseObject) -> Void in

            let dictArray:NSArray = responseObject["statuses"] as! NSArray
            // 缓存新浪返回的字典数组
            HWStatusToolSQ.saveStatuses(dictArray)

            dealingResultBlock(dictArray)
            

            }) { (error) -> Void in
                print("*****请求失败")
                self.tableView.mj_header.endRefreshing()
            }
        }
    }
    

    /** 加载更多的微博数据 */
    //uuu
    func loadMoreStatus(){
        // 1.请求管理者
        //let mgr:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        
        // 2.拼接请求参数
        // 2.拼接请求参数
        let account:HMAccountModel = HMAccountTool.loadAccount()!
        let params:NSMutableDictionary = NSMutableDictionary()

        params["access_token"] = account.access_token;
        
        
        // 取出最后面的微博（最新的微博，ID最大的微博）
        //不可以 as? HWStatus
        //    let lastStatus = self.statusFrames!.lastObject as? HWStatus
            let lastStatus = self.statusFrames!.lastObject as? HWStatusFrame
        if lastStatus != nil {
            
            // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
            // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
            params["max_id"] = (lastStatus!.status!.idstr?.integerValue)! - 1
                
        }
        
        //MARK: 闭包带参数
        // 定义一个block处理返回的字典数据
        let dealingResultBlock: (NSArray) -> Void = { (dictArray) in
            
            // 将 "微博字典"数组 转为 "微博模型"数组
            let newStatuses = (HWStatus.objectArrayWithKeyValuesArray(dictArray as [AnyObject]) as AnyObject) //as? NSMutableArray)!
            // 将 HWStatus数组 转为 HWStatusFrame数组
            let newFrames = self.stausFramesWithStatuses(newStatuses as! NSArray)
            
            // 将更多的微博数据，添加到总数组的最后面
            self.statusFrames!.addObjectsFromArray(newFrames as [AnyObject])
            
            // 刷新表格
            self.tableView.reloadData()
            
            // 结束刷新(隐藏footer)
            self.tableView.mj_footer.endRefreshing()
        }

        
        // 2.先尝试从数据库中加载微博数据
        let statuses: NSArray? = HWStatusToolSQ.statusesWithParams(params)!
        print("*****\(statuses?.count)")
        if (statuses!.count != 0) {
            // 数据库有缓存数据
            dealingResultBlock(statuses!)
            
        } else {
        
        
        
        // 3.发送请求
        //https://api.weibo.com/2/statuses/friends_timeline.json
        
        HWHttpTool.get("https://api.weibo.com/2/statuses/friends_timeline.json", params: params as NSDictionary, success: { (responseObject) -> Void in
            
            let dictArray:NSArray = responseObject["statuses"] as! NSArray
            // 缓存新浪返回的字典数组
            HWStatusToolSQ.saveStatuses(dictArray)
            
            dealingResultBlock(dictArray)
            
            }) { (error) -> Void in
                print("*****请求失败")
                // 结束刷新(隐藏footer)
                //self.tableView.tableFooterView!.hidden = true
                self.tableView.mj_footer.endRefreshing()

            }
        }
    }
    
    
    
    /**
    *  显示最新微博的数量
    *
    *  @param count 最新微博的数量
    */
    func showNewStatusCount(count:Int){
        
        // 刷新成功(清空图标数字)
        self.tabBarItem.badgeValue = nil;
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0

        // 1.创建label
        let label:UILabel = UILabel()

        label.backgroundColor = UIColor(patternImage: UIImage(named: "timeline_new_status_background")!)
        label.frame.size.width = UIScreen.mainScreen().bounds.size.width
        label.frame.size.height = 35;


        // 2.设置其他属性
        if (count == 0) {
            label.text = "没有新的微博数据，稍后再试";
            
        } else {
            label.text = "共有\(count)条新的微博数据"
        }
            label.textColor = UIColor.whiteColor()
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont.systemFontOfSize(15.0)

        // 3.添加
        label.frame.origin.y = 64 - label.frame.size.height;
        // 将label添加到导航控制器的view中，并且是盖在导航栏下边
        
        self.navigationController!.view.insertSubview(label, belowSubview:(self.navigationController?.navigationBar)!)
       
        
        // 4.动画
        // 先利用1s的时间，让label往下移动一段距离
        let duration:Double = 1.0; // 动画的时间
        UIView.animateWithDuration(duration, animations: { () -> Void in
            //    [label removeFromSuperview];
            
            label.transform = CGAffineTransformMakeTranslation(0, label.frame.size.height)
            
            
            }) { (finshed) -> Void in

                // 延迟1s后，再利用1s的时间，让label往上移动一段距离（回到一开始的状态）
                let delay:Double = 1.0 // 延迟1s
                // UIViewAnimationOptionCurveLinear:匀速
                UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    //            label.y -= label.height;
                    label.transform = CGAffineTransformIdentity
                    
                    }, completion: { (finished) -> Void in
                         label.removeFromSuperview()
                })

        }

        
    // 如果某个动画执行完毕后，又要回到动画执行前的状态，建议使用transform来做动画
        
        
    }
    
    
    
    

    
    
    /**
    *  获得用户信息（昵称）
    */
    func setupUserInfo(){
        
    // https://api.weibo.com/2/users/show.json
    // access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    // uid	false	int64	需要查询的用户ID。
    // 1.请求管理者
    //let mgr:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
  
    // 2.拼接请求参数
        let account:HMAccountModel = HMAccountTool.loadAccount()!
        let params:NSMutableDictionary = NSMutableDictionary()

        params["access_token"] = account.access_token;
        params["uid"] = account.uid;
    
    // 3.发送请求
        
        HWHttpTool.get("https://api.weibo.com/2/users/show.json", params: params, success: { (responseObject) -> Void in
            /// 标题按钮
            let titleButton:UIButton = self.navigationItem.titleView as! UIButton
            /// 设置名字
            //let user:NSArray = HWUser.objectArrayWithKeyValuesArray(responseObject)

            let name:NSString = responseObject["name"] as! NSString
            
            // 设置名字
            
            titleButton.setTitle(name as String, forState: UIControlState.Normal)
            /// 存储昵称到沙盒中
            account.name = name
            HMAccountTool.saveAccount(account)
            
            }) { (error) -> Void in
                print("*****请求失败")
        }
    
    }
    
    
    
    
    /**
    *  设置导航栏内容
    */
    func setupNav(){
        
        /* 设置导航栏上面的内容 */
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.ItemWithImageTarget(self, action: "friendSearch", image: "navigationbar_friendsearch", hightImage: "navigationbar_friendsearch_highlighted")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.ItemWithImageTarget(self, action: "pop", image: "navigationbar_pop", hightImage: "navigationbar_pop_highlighted")
        
        ///* 中间的标题按钮 */继承自定义按钮
        //    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        let titleButton:HMTitleButton = HMTitleButton()
        //self.navigationItem.rightBarButtonItem?.enabled = false
        
        /// 设置图片和文字
        let name = (HMAccountTool.loadAccount()?.name) as? String
        
        titleButton.setTitle(name ?? "首页", forState: UIControlState.Normal)
        print("*用户昵称--\(name)")
        
        //        titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
        //        titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
        
        /// 监听标题点击
        titleButton.addTarget(self, action: "titleClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationItem.titleView = titleButton;

    }
    // 如果图片的某个方向上不规则，比如有突起，那么这个方向就不能拉伸
    // 什么情况下建议使用imageEdgeInsets、titleEdgeInsets
    // 如果按钮内部的图片、文字固定，用这2个属性来设置间距，会比较简单
    // 标题宽度
    //    CGFloat titleW = titleButton.titleLabel.width * [UIScreen mainScreen].scale;
    ////    // 乘上scale系数，保证retina屏幕上的图片宽度是正确的
    //    CGFloat imageW = titleButton.imageView.width * [UIScreen mainScreen].scale;
    //    CGFloat left = titleW + imageW;
    //    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
    
/**
    *  标题点击
    */
    func titleClick(titleButton:UIButton){
        // 1.创建下拉菜单
            let menu:HMDropdownMenu = HMDropdownMenu.menu()
            menu.delegate = self
        // 2.设置内容
            let vc:HWTitleMenuViewController = HWTitleMenuViewController()
        
        vc.view.frame.size.height = 150;
        vc.view.frame.size.width = 150;
        menu.contentController = vc;
        
        // 3.显示
        menu.showFrom(titleButton)
    }
    
    
    func friendSearch()
    {
    NSLog("friendSearch");
    }
    
    func pop()
    {
    NSLog("pop");
    }
    
    //MARK: - HWDropdownMenuDelegate
    /**
    *  下拉菜单被销毁了
    */
    func dropdownMenuDidDismiss(menu: HMDropdownMenu) {
        
        let titleButton:HMTitleButton = self.navigationItem.titleView as! HMTitleButton
        
        titleButton.selected = false
        
        // 让箭头向下
        //    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }
    
    /**
    *  下拉菜单显示了
    */
    func dropdownMenuDidShow(menu: HMDropdownMenu) {
        
         let titleButton:HMTitleButton = self.navigationItem.titleView as! HMTitleButton
        
        titleButton.selected = true
        // 让箭头向上
        //   [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    }

    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  self.statusFrames?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        // 获得cell
        let cell:HWStatusCell  = HWStatusCell.cellWithTableView(tableView)
        
        // 给cell传递模型数据
        cell.statusFrame = self.statusFrames![indexPath.row] as? HWStatusFrame;
        
        return cell;
        
    }
    
    
    
//    override func scrollViewDidScroll(scrollView: UIScrollView) {
//
//       
//        // 如果tableView还没有数据，就直接返回
//        if (self.statusFrames!.count == 0) || self.tableView.tableFooterView?.hidden == true {
//            
//            return
//        }
//        //    if ([self.tableView numberOfRowsInSection:0] == 0) return;
//        
//        // 当最后一个cell完全显示在眼前时，contentOffset的y值
//        let offsetY:CGFloat = scrollView.contentOffset.y
//        
//        if let taheight = self.tableView.tableFooterView?.frame.size.height {
//            
//            let judgeOffsetY:CGFloat = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.frame.size.height - taheight
//            
//            if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
//                // 显示footer
//                self.tableView.tableFooterView?.hidden = false
//                // 加载更多的微博数据
//                self.loadMoreStatus()
//                print("加载更多的微博数据")
//            }
//            
//            
//        }

//    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let frame: HWStatusFrame  = self.statusFrames![indexPath.row] as! HWStatusFrame;
        return frame.cellHeight!;
    }
    /*
    contentInset：除具体内容以外的边框尺寸
    contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
    contentOffset:
    1.它可以用来判断scrollView滚动到什么位置
    2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
    */
    }
    
    /**
    1.将字典转为模型
    2.能够下拉刷新最新的微博数据
    3.能够上拉加载更多的微博数据
    */
    


  
