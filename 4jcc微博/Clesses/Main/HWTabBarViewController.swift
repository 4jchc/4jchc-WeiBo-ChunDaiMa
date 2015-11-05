//
//  HWTabBarViewController.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWTabBarViewController: UITabBarController,HMTabBarDelegate{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // 1.初始化子控制器
        let home:HWHomeViewController = HWHomeViewController()
        self.addChildVc(home, title: "首页", image: "tabbar_home", selectedImage: "tabbar_home_selected")
        
        
        let messageCenter:HWMessageCenterViewController = HWMessageCenterViewController()
        self.addChildVc(messageCenter, title: "消息", image: "tabbar_message_center", selectedImage: "tabbar_message_center_selected")
        
        let discover:HWDiscoverViewController = HWDiscoverViewController()
        self.addChildVc(discover, title: "发现", image: "tabbar_discover", selectedImage: "tabbar_discover_selected")
        
        let profile:HWProfileViewController = HWProfileViewController()
        self.addChildVc(profile, title: "我", image: "tabbar_profile", selectedImage: "tabbar_profile_selected")
        
        ////*****✅ 2.更换系统自带的tabbar
        //    self.tabBar = [[HWTabBar alloc] init];
        let tabBar:HMTabBar = HMTabBar()
        tabBar.delegateHM = self;
        self.setValue(tabBar, forKeyPath: "tabBar")
     
        //    self.tabBar = tabBar;
        
        
    }

    

    
    
    /**
    *  添加一个子控制器
    *
    *  @param childVc       子控制器
    *  @param title         标题
    *  @param image         图片
    *  @param selectedImage 选中的图片
    */
    func addChildVc(childVc:UIViewController,title:NSString ,image:NSString, selectedImage:NSString){
        
        
        // 设置文字的样式
        let normalcolor = UIColor(red: 123/255.0, green: 123/255.0, blue: 123/255.0, alpha: 1.0)
        
        let selectedcolor = UIColor.orangeColor()
        
        
        // 设置子控制器的文字和图片
                
        // 设置子控制器的文字
        childVc.title = title as String // 同时设置tabbar和navigationBar的文字
        // 设置tabbar的文字
//        childVc.tabBarItem.title = title as String
        
        // 设置navigationBar的文字
//        childVc.navigationItem.title = title as String
        
        
        childVc.tabBarItem.image = UIImage(named: image as String)
        // 声明：这张图片按照原始的样子显示出来，不要自动渲染成其他颜色（比如蓝色）
        childVc.tabBarItem.selectedImage = UIImage(named: selectedImage as String)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        // 设置子控制器的文字和图片
        childVc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: normalcolor], forState: UIControlState.Normal)
        childVc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: selectedcolor], forState: UIControlState.Selected)
        ///view的颜色创建就会同时加载所有视图
       // childVc.view.backgroundColor = UIColor.random()
        
        
        ////*****✅/ 先给外面传进来的小控制器 包装 一个导航控制器
        let nav:HWNavigationController = HWNavigationController(rootViewController: childVc)

        /// 添加为子控制器
        self.addChildViewController(nav)

        
        
    }
    
    ///*****✅#pragma mark - HWTabBarDelegate代理方法
    
    func tabBarDidClickPlusButton(tabBar:HMTabBar){
        
        let vc:UIViewController = UIViewController()
        vc.view.backgroundColor = UIColor.redColor()
        self.presentViewController(vc, animated: true, completion: nil)

    }
    
 
    
    
    

    

}
