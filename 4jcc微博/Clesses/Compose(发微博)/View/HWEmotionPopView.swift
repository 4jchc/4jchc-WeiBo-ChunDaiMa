//
//  HWEmotionPopView.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWEmotionPopView: UIView {

    
    @IBOutlet weak var emotionButton: HWEmotionButton!
    
    static func popView()->HWEmotionPopView{
        return NSBundle.mainBundle().loadNibNamed("HWEmotionPopView", owner: nil, options: nil).last as! HWEmotionPopView
    }
    
    func showFrom(button:HWEmotionButton?){
        if let btn = button{
            // 给popView传递数据
            self.emotionButton.emotion=btn.emotion
            
            // 取得最上面的window
            let window = UIApplication.sharedApplication().windows.last
            window?.addSubview(self)
            
            // 计算出被点击的按钮在window中的frame
            let btnFrame = btn.convertRect(btn.bounds, toView: nil)
            self.frame.origin.y=CGRectGetMidY(btnFrame)-self.frame.size.height //100
            self.center.x=CGRectGetMidX(btnFrame)
        }
    }

}
