//
//  HMTabBar.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/5.
//  Copyright © 2015年 sijichcai. All rights reserved.


import UIKit
    ///*****✅#warning 因为HWTabBar继承自UITabBar，所以称为HWTabBar的代理，也必须实现UITabBar的代理协议

protocol HMTabBarDelegate:NSObjectProtocol{
    
   func tabBarDidClickPlusButton(tabBar:HMTabBar)
    
}

class HMTabBar: UITabBar {

    weak var plusBtn:UIButton!
    
    var delegateHM:HMTabBarDelegate!


    
    ///*****✅init(frame:CGRect)里设置属性
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 添加一个按钮到tabbar中
        let plusBtn:UIButton = UIButton()
        plusBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        plusBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
   
        plusBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        plusBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        plusBtn.frame.size = plusBtn.currentBackgroundImage!.size;
        plusBtn.addTarget(self, action: "plusClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(plusBtn)
        self.plusBtn = plusBtn

        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
//#warning [super layoutSubviews] 一定要调用
        super.layoutSubviews()
        
        // 1.设置加号按钮的位置
        
        self.plusBtn.center.x = self.frame.size.width * 0.5;
        self.plusBtn.center.y = self.frame.size.height * 0.5;
        
        // 2.设置其他tabbarButton的位置和尺寸
        let tabbarButtonW:CGFloat = self.frame.size.width / 5
        
        var tabbarButtonIndex:CGFloat = 0
     
        for child in self.subviews{
            let Class:AnyClass = NSClassFromString("UITabBarButton")!
     
            if child.isKindOfClass(Class) {
                
                // 设置宽度
                child.frame.size.width = tabbarButtonW;
                // 设置x
                child.frame.origin.x = tabbarButtonIndex * tabbarButtonW;
                
                // 增加索引
                tabbarButtonIndex++;
                if (tabbarButtonIndex == 2) {
                    tabbarButtonIndex++;
                }
            }
        }
    }
 
    
    /**
    *  加号按钮点击
    */
    func plusClick(){
        
    // 通知代理
        if (self.delegateHM != nil){
            print("*****\(self.delegateHM)")
            self.delegateHM.tabBarDidClickPlusButton(self)
            
        }
        

    }
}