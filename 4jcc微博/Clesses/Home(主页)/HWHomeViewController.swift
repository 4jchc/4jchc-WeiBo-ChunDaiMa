//
//  HWHomeViewController.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWHomeViewController: UITableViewController,HMDropdownMenuDelegate {

    //var titleButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航栏内容
        self.setupNav()
        
        // 获得用户信息（昵称）
        self.setupUserInfo()
        
    }

    /**
    *  获得用户信息（昵称）
    */
    func setupUserInfo(){
        
    // https://api.weibo.com/2/users/show.json
    // access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    // uid	false	int64	需要查询的用户ID。
    // 1.请求管理者
        let mgr:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
  
    // 2.拼接请求参数
        let account:HMAccountModel = HMAccountTool.loadAccount()!
        let params:NSMutableDictionary = NSMutableDictionary()

        params["access_token"] = account.access_token;
        params["uid"] = account.uid;
    
    // 3.发送请求
        mgr.GET("https://api.weibo.com/2/users/show.json", parameters: params, success: { (operation, responseObject) -> Void in
            /// 标题按钮
            let titleButton:UIButton = self.navigationItem.titleView as! UIButton
            /// 设置名字
            let name:NSString = responseObject["name"] as! NSString
            titleButton.setTitle(name as String, forState: UIControlState.Normal)
            /// 存储昵称到沙盒中
            account.name = name;
            
            HMAccountTool.saveAccount(account)
            
            }) { (operation, error) -> Void in
                print("*****请求失败")
        }
    
    }
    
    
    /**
    *  设置导航栏内容
    */
    func setupNav(){
        
        /* 设置导航栏上面的内容 */
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.addImageTarget(self, action: "friendSearch", image: "navigationbar_friendsearch", hightImage: "navigationbar_friendsearch_highlighted")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.addImageTarget(self, action: "pop", image: "navigationbar_pop", hightImage: "navigationbar_pop_highlighted")
        
        ///* 中间的标题按钮 */
        //    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        let titleButton:HMTitleButton = HMTitleButton()
        
        
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
    
    ///*****✅#pragma mark - HWDropdownMenuDelegate
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
        //    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    }

    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
