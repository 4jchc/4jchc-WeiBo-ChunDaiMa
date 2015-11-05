//
//  HMDropdownMenu.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/4.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit
///*****✅监听下拉菜单的点击和销毁来改变被点击按钮的图片状态
    protocol HMDropdownMenuDelegate:NSObjectProtocol{
    
    func dropdownMenuDidDismiss(menu:HMDropdownMenu)
    
    func dropdownMenuDidShow(menu:HMDropdownMenu)
   
    
}

class HMDropdownMenu: UIView {
    
    weak var delegate:HMDropdownMenuDelegate?
    
    /**
    *  内容
    */
    var content:UIView!{
        
        didSet{
            
            content.frame.origin.x = 10
            content.frame.origin.y = 15;
            
            // 调整内容的宽度
            //  content.width = self.containerView.width - 2 * content.x;
            
            // 设置灰色的高度
            self.containerView.frame.size.height = CGRectGetMaxY(content.frame) + 11;
            // 设置灰色的宽度
            self.containerView.frame.size.width = CGRectGetMaxX(content.frame) + 10;
            
            // 添加内容到灰色图片中
            self.containerView.addSubview(content)
            
        }
        
    }
    

    /**
    *  内容控制器
    */
    var contentController:UIViewController!{
        
        didSet{
           
            self.content = contentController.view
            
        }
        
    }

    

    /**
    *  将来用来显示具体内容的容器
    */
    
///*****懒加载--不能用
//   lazy var containerView:UIImageView =  {
//    
//    let tempContainView:UIImageView = UIImageView()
//    // 添加一个灰色图片控件
//    tempContainView.image = UIImage(named: "popover_background")
//    // 添加一个灰色图片控件
//    tempContainView.userInteractionEnabled = true
//    
//    let im:HMDropdownMenu = HMDropdownMenu()
//    im.addSubview(tempContainView)
//    self = im
//    return tempContainView
//    }()
    
///***** set方法--不能用
//    var containerView:UIImageView {
//        
//        didSet{
//            
//            let tempContainView:UIImageView = UIImageView()
//            // 添加一个灰色图片控件
//            tempContainView.image = UIImage(named: "popover_background")
//            // 添加一个灰色图片控件
//            tempContainView.userInteractionEnabled = true
//            
//            self.addSubview(tempContainView)
//            
//        }
//        
//    }
    
   
    var _containerView:UIImageView!
    
    var containerView:UIImageView {
        
        get{
            if _containerView == nil {
                
                _containerView = UIImageView()
                // 添加一个灰色图片控件
                _containerView.image = UIImage(named: "popover_background")
                // 添加一个灰色图片控件
                _containerView.userInteractionEnabled = true
                self.addSubview(_containerView)
            }
            return _containerView
        }
    }



    
    /**
    *  显示
    */
    func showFrom(from:UIView){

        
        
        // 1.获得最上面的窗口
        let window:UIWindow = UIApplication.sharedApplication().windows.last!
        
        // 2.添加自己到窗口上
        window.addSubview(self)
    
        // 3.设置尺寸
        self.frame = window.frame;

        // 4.调整灰色图片的位置
        // 默认情况下，frame是以父控件左上角为坐标原点
        // 转换坐标系

         let newFrame:CGRect = from.convertRect(from.bounds, toView: window)

         self.containerView.center.x = CGRectGetMidX(newFrame)
       
        
        self.containerView.frame.origin.y = CGRectGetMaxY(newFrame);
   
        /// 通知外界，自己显示了
        if self.delegate != nil{
            
            self.delegate?.dropdownMenuDidShow(self)
        }
        
        
        
    }
    /**
    *  销毁
    */
    func dismiss(){
        
         self.removeFromSuperview()
        /// 通知外界，自己被销毁了
        if self.delegate != nil{
            
            self.delegate?.dropdownMenuDidDismiss(self)
        }
        
        
    }

  
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
    }

    
 
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

    
  class func menu() ->HMDropdownMenu{
    
    
   return self.init()
   
        
    }
    

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.dismiss()
    }

}
