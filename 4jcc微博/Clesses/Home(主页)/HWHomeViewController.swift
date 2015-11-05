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

        /* 设置导航栏上面的内容 */
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.addImageTarget(self, action: "friendSearch", image: "navigationbar_friendsearch", hightImage: "navigationbar_friendsearch_highlighted")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.addImageTarget(self, action: "pop", image: "navigationbar_pop", hightImage: "navigationbar_pop_highlighted")
        

        
        ///* 中间的标题按钮 */
        //    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        let titleButton:UIButton = UIButton()
        
        titleButton.frame.size.width = 150;
        titleButton.frame.size.height = 30;
        //    titleButton.backgroundColor = HWRandomColor;
        
        /// 设置图片和文字
        titleButton.setTitle("首页", forState: UIControlState.Normal)
        titleButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)

        titleButton.titleLabel!.font = UIFont.boldSystemFontOfSize(13.0)
        titleButton.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        titleButton.setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        
        //    titleButton.imageView.backgroundColor = [UIColor redColor];
        //    titleButton.titleLabel.backgroundColor = [UIColor blueColor];
        titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
        titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
        
        /// 监听标题点击
        titleButton.addTarget(self, action: "titleClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationItem.titleView = titleButton;
        // 如果图片的某个方向上不规则，比如有突起，那么这个方向就不能拉伸
        

        
    }
    
    
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
        
        let titleButton:UIButton = self.navigationItem.titleView as! UIButton
        
        titleButton.selected = false
        
        // 让箭头向下
        //    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }
    
    /**
    *  下拉菜单显示了
    */
    func dropdownMenuDidShow(menu: HMDropdownMenu) {
        
         let titleButton:UIButton = self.navigationItem.titleView as! UIButton
        
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
