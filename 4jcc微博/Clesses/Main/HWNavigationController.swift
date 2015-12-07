//
//  HWNavigationController.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWNavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        
//        print(__FUNCTION__)
//        let item:UIBarButtonItem = UIBarButtonItem.appearance()
//        // 设置普通状态
//        // key：NS****AttributeName
//        //颜色
//        let attributesNormal =  [NSForegroundColorAttributeName: UIColor.orangeColor(),            NSFontAttributeName: UIFont(name: "Heiti SC", size: 13.0)!]
//        item.setTitleTextAttributes(attributesNormal, forState: UIControlState.Normal)
//        
//        //字体
//        /// 设置不可用状态
//        let attributesDisabled =  [NSForegroundColorAttributeName: UIColor.RGB(0.6, 0.6, 0.6, 0.8), NSFontAttributeName: UIFont(name: "Heiti SC", size: 13.0)!]
//        //let attributesDisabled =  [NSForegroundColorAttributeName: UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.6), NSFontAttributeName: UIFont(name: "Heiti SC", size: 13.0)!]
//        item.setTitleTextAttributes(attributesDisabled, forState: UIControlState.Disabled)
//        //self.navigationItem.rightBarButtonItem?.enabled = false
    }
//
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }


    
    
    
    
    
    
    
    
    
    
    
    ///*****✅程序一开始就会调用
    override class func initialize() {

        print(__FUNCTION__)
        let item:UIBarButtonItem = UIBarButtonItem.appearance()
        // 设置普通状态
        // key：NS****AttributeName
        //颜色
        let attributesNormal =  [NSForegroundColorAttributeName: UIColor.orangeColor(),            NSFontAttributeName: UIFont(name: "Heiti SC", size: 13.0)!]
        item.setTitleTextAttributes(attributesNormal, forState: UIControlState.Normal)
        
        //字体
        /// 设置不可用状态
        let attributesDisabled =  [NSForegroundColorAttributeName: UIColor.RGB(1, 1, 1, 1), NSFontAttributeName: UIFont(name: "Heiti SC", size: 15.0)!]

        item.setTitleTextAttributes(attributesDisabled, forState: UIControlState.Disabled)

    }
    
    
    
    
    
    ///*****✅initialize()里的颜色要在viewDidAppear中才有效
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //self.navigationItem.rightBarButtonItem?.enabled = false
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.rightBarButtonItem?.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /**
    *  重写这个方法目的：能够拦截所有push进来的控制器
    *
    *  @param viewController 即将push进来的控制器
    */
    override func showViewController(vc: UIViewController, sender: AnyObject?) {
        if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
            ///* 自动显示和隐藏tabbar */
            vc.hidesBottomBarWhenPushed = true
            
            ///* 设置导航栏上面的内容 */
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem.ItemWithImageTarget(self, action: "back", image: "navigationbar_back", hightImage: "navigationbar_back_highlighted")
            vc.navigationItem.rightBarButtonItem = UIBarButtonItem.ItemWithImageTarget(self, action: "more", image: "navigationbar_more", hightImage: "navigationbar_more_highlighted")
            
        }
        
        // 跳转
        if (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0{
            super.showViewController(vc, sender: sender)
        } else {
            super.pushViewController(vc, animated: true)
        }
        
 
    }
    
    
    
    
    
    
    func back(){
    ///*****✅#warning 这里要用self，不是self.navigationController
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    self.popViewControllerAnimated(true)
    }
    
    func more(){
        
    self.popToRootViewControllerAnimated(true)
  
    }


    
}











