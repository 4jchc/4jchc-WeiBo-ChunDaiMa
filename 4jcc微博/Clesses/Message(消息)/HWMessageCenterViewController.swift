//
//  HWMessageCenterViewController.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWMessageCenterViewController: UITableViewController{



    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let ID:NSString = "cell"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "set", style: UIBarButtonItemStyle.Plain, target: self, action: "setting")
       
    }
    func setting(){
        let v1 = HWTest2ViewController()
        self.navigationController?.pushViewController(v1, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }


 
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let ID:NSString = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier("cell" as String)
        
        if cell == nil{
            
            
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell" as String)
        }
    
        cell!.textLabel?.text = "test-message-\(indexPath.row) "

        return cell!
    }

    //#pragma mark - 代理方法
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let test1:HWTest1ViewController = HWTest1ViewController()
        
            test1.title = "测试1控制器";
        // 当test1控制器被push的时候，test1所在的tabbarcontroller的tabbar会自动隐藏
        // 当test1控制器被pop的时候，test1所在的tabbarcontroller的tabbar会自动显示
        test1.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(test1, animated: true)
       
    }
    
    
    
    
    
    


}
