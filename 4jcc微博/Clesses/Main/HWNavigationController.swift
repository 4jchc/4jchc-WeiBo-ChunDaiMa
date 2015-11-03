//
//  HWNavigationController.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
  
    
//    - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//    {
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//    // Custom initialization
//    }
//    return self;
//    }
//    

    
    /**
    *  重写这个方法目的：能够拦截所有push进来的控制器
    *
    *  @param viewController 即将push进来的控制器
    */
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
            ///* 自动显示和隐藏tabbar */
            viewController.hidesBottomBarWhenPushed = true
            
            ///* 设置导航栏上面的内容 */
            let backBtn:UIButton = UIButton(type: UIButtonType.Custom)
                backBtn.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)

            // 设置图片
            backBtn.setBackgroundImage(UIImage(named: "navigationbar_back"), forState: UIControlState.Normal)
            backBtn.setBackgroundImage(UIImage(named: "navigationbar_back_highlighted"), forState: UIControlState.Highlighted)
            
            // 设置尺寸
            backBtn.frame.size = (backBtn.currentBackgroundImage?.size)!
           
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            let moreBtn:UIButton = UIButton(type: UIButtonType.Custom)
            moreBtn.addTarget(self, action: "more", forControlEvents: UIControlEvents.TouchUpInside)

            // 设置图片
            moreBtn.setBackgroundImage(UIImage(named: "navigationbar_more"), forState: UIControlState.Normal)
            moreBtn.setBackgroundImage(UIImage(named: "navigationbar_more_highlighted"), forState: UIControlState.Highlighted)
 
            // 设置尺寸
            
            moreBtn.frame.size = moreBtn.currentBackgroundImage!.size;
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreBtn)
        }
        super.pushViewController(viewController, animated: animated)
       
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
