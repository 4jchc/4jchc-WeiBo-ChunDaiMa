//
//  Extansion.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/3.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import Foundation
import UIKit
/** UIBarButtonItem--UIColor--  */







///*✅************************💗 UIBarButtonItem *******************************
///*****✅自定义--BarButtonItem 
// 1.增加自定义图片的高亮和普通状态
// 2.添加行为action




///*✅************************💗 UITabBarController *******************************

//extension UITabBarController{
//    
//    
//    /**
//    *  添加一个子控制器
//    *
//    *  @param childVc       子控制器
//    *  @param title         标题
//    *  @param image         图片
//    *  @param selectedImage 选中的图片
//    */
//    
//  class  func addNavigationController(childVc:UIViewController,title:NSString ,image:NSString, selectedImage:NSString,normalcolor:UIColor,selectedcolor:UIColor){
//        
//        // 设置文字的样式
//        let normalcolor = UIColor(red: 123/255.0, green: 123/255.0, blue: 123/255.0, alpha: 1.0)
//        
//        let selectedcolor = UIColor.orangeColor()
//        
//        // 设置子控制器的文字和图片
//        
//        // 设置子控制器的文字
//        childVc.title = title as String // 同时设置tabbar和navigationBar的文字
//        // 设置tabbar的文字
//        //childVc.tabBarItem.title = title as String
//        
//        // 设置navigationBar的文字
//        //hildVc.navigationItem.title = title as String
//        
//        childVc.tabBarItem.image = UIImage(named: image as String)
//        // 声明：这张图片按照原始的样子显示出来，不要自动渲染成其他颜色（比如蓝色）
//        childVc.tabBarItem.selectedImage = UIImage(named: selectedImage as String)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//        
//        // 设置子控制器的文字和图片
//        childVc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: normalcolor], forState: UIControlState.Normal)
//        childVc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: selectedcolor], forState: UIControlState.Selected)
//        
//        childVc.view.backgroundColor = UIColor.random()
//        
//        
//        ////*****✅/ 先给外面传进来的小控制器 包装 一个导航控制器
//        let nav:UINavigationController = UINavigationController(rootViewController: childVc)
//    
//       // let nav = childNc(rootViewController: childVc)
//        
//        /// 添加为子控制器
//    
//    UITabBarController.addChildViewController(nav)
//        
//    }
//    
//}









///*✅************************💗 UITextField *******************************

//extension UITextField{
//    
//    class func addSearchBar() ->AnyObject{
//        ///*****✅自定义搜索框
//        // 创建搜索框对象
//        let searchBar:UITextField = UITextField()
//        searchBar.frame.size.width = 300;
//        searchBar.frame.size.height = 30;
//        
//        searchBar.font = UIFont.systemFontOfSize(15)
//        searchBar.placeholder = "请输入搜索条件"
//        searchBar.background = UIImage(named: "searchbar_textfield_background")
//        
//        
//        /// 通过init来创建初始化绝大部分控件，控件都是没有尺寸
//        let searchIcon:UIImageView = UIImageView()
//        ///*****✅搜索图标--UIImageView
//        searchIcon.image = UIImage(named: "searchbar_textfield_search_icon")
//        searchIcon.frame.size.width = 30;
//        searchIcon.frame.size.height = 30;
//        searchIcon.contentMode = UIViewContentMode.Center
//        ///添加图片到左边
//        searchBar.leftView = searchIcon;
//        searchBar.leftViewMode = UITextFieldViewMode.Always
//        
//        return searchBar
//    }
//    
//}










