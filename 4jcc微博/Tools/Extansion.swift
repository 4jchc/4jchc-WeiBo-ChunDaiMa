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
extension UIBarButtonItem{
    
    /**
    *  创建一个item
    *
    *  @param target    点击item后调用哪个对象的方法
    *  @param action    点击item后调用target的哪个方法
    *  @param image     图片
    *  @param highImage 高亮的图片
    *
    *  @return 创建完的item
    */
   class func addImageTarget(target:AnyObject?,action:Selector,image:NSString,hightImage:NSString) ->UIBarButtonItem{
        
        let btn:UIButton = UIButton(type: UIButtonType.Custom)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        // 设置图片
        btn.setBackgroundImage(UIImage(named: image as String), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: hightImage as String), forState: UIControlState.Highlighted)
        
        // 设置尺寸
        btn.frame.size = btn.currentBackgroundImage!.size;
        
        return UIBarButtonItem(customView: btn)
        
    }
}




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







///*✅************************💗 UIColor *******************************


///*****✅随机颜色color
extension UIColor {
    
    class func random() -> UIColor {
    /*
    颜色有两种表现形式 RGB RGBA
    RGB 24
    R,G,B每个颜色通道8位
    8的二进制 255
    R,G,B每个颜色取值 0 ~255
    120 / 255.0
    */
        let r:CGFloat = CGFloat(arc4random_uniform(UInt32(256))) / 255.0
        let g:CGFloat = CGFloat(arc4random_uniform(UInt32(256))) / 255.0
        let b:CGFloat = CGFloat(arc4random_uniform(UInt32(256))) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    //UIColor(red: <#123#>/255.0, green: <#123#>/255.0, blue: <#123#>/255.0, alpha: 1.0)
    
   class func RGB(r:CGFloat,_ g:CGFloat, _ b:CGFloat)->UIColor{
        
        
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
}



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



///*✅************************💗 UIWindow *******************************

extension UIWindow{
    
    
     func switchRootViewController(){
        
        /// 设置根控制器
        let key:NSString = "CFBundleVersion"
        // 上一次的使用版本（存储在沙盒中的版本号）
        
        
        let lastVersion = NSUserDefaults.standardUserDefaults().objectForKey(key as String) as? String
        
        // 当前软件的版本号（从Info.plist中获得）
        
        let infoDict:NSDictionary = NSBundle.mainBundle().infoDictionary!
        
        let currentVersion = infoDict.objectForKey(key as String) as! String
        
      
        ////*****✅ 加class是类方法类方法无法使用self  所以改为实例方法
        if (currentVersion == lastVersion) { // 版本号相同：这次打开和上次打开的是同一个版本
            
            self.rootViewController = HWTabBarViewController()
            
        } else { // 这次打开的版本和上一次不一样，显示新特性
            
            self.rootViewController = HMNewfeatureViewController()
            // 将当前的版本号存进沙盒
            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: key as String)
            
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
        
    }
    
    
}












