//
//  HWProfileViewController.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWProfileViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // let ID:NSString = "cell"

         self.navigationItem.rightBarButtonItem?.enabled = false
        
        let seachbar:HMSearchBar = HMSearchBar.SeachBar()
        seachbar.frame.size.width = 300
        seachbar.frame.size.height = 30
        seachbar.frame.origin.x = 21
        view.addSubview(seachbar)
        
        // 字节大小
        let byteSize  = (SDImageCache.sharedImageCache)().getSize()
        // M大小
        let size:Double  = Double(byteSize / 1000 / 1000)
        self.navigationItem.title = "缓存大小(\(size)M)"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "清除缓存",style: UIBarButtonItemStyle.Done, target: self, action: "clearCache")
        self.fileOperation()
        
        
    }
    
    
    
    
    func fileOperation(){
        // 文件管理者
        let mgr: NSFileManager = NSFileManager.defaultManager()
        // 缓存路径
        let caches = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as NSString
        try! mgr.removeItemAtPath(caches as String)
        
    }
    
    
    
    
    
    
    /**
     NSString *filepath = [caches stringByAppendingPathComponent:@"cn.heima.----2-/Cache.db-wal"];
     
     // 获得文件\文件夹的属性(注意:文件夹是没有大小属性的,只有文件才有大小属性)
     NSDictionary *attrs = [mgr attributesOfItemAtPath:filepath error:nil];
     HWLog(@"%@ %@", caches, attrs);
     */
    
    
    
    
    
    
    func clearCache(){
        // 提醒
        let circle: UIActivityIndicatorView  = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        circle.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: circle)
        
        // 清除缓存
        SDImageCache.sharedImageCache().clearDisk()
        
        // 显示按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "清除缓存",style: UIBarButtonItemStyle.Done, target: self, action: "clearCache")
        self.navigationItem.title = "缓存大小(0M)"
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func setting(){
        let v1 = HWTest2ViewController()
        self.navigationController?.pushViewController(v1, animated: true)
        
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



}
