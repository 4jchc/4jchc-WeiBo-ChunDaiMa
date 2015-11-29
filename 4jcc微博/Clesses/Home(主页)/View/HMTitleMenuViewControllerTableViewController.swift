//
//  HMTitleMenuViewControllerTableViewController.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/11/28.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HMTitleMenuViewControllerTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let ID:NSString = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID as NSString as String)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID as String)
        }
        if (indexPath.row == 0) {
            cell!.textLabel!.text = "好友";
        } else if (indexPath.row == 1) {
            cell!.textLabel!.text = "密友";
        } else if (indexPath.row == 2) {
            cell!.textLabel!.text = "全部";
        }

        return cell!
    }


  }
