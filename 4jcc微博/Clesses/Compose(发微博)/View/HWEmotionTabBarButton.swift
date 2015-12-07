//
//  HWEmotionTabBarButton.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWEmotionTabBarButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        // 设置文字颜色
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Disabled)
        // 设置字体
        self.titleLabel?.font=UIFont.systemFontOfSize(13)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var highlighted:Bool{
        get{
            return false
        }
        set{
            
        }
    }

}
