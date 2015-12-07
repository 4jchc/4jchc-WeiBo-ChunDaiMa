//
//  HWComposeToolbar.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/3.
//  Copyright © 2015年 sijichcai. All rights reserved.
//


import UIKit

enum HWComposeToolbarButtonType:Int{
    case HWComposeToolbarButtonTypeCamera, // 拍照
    HWComposeToolbarButtonTypePicture, // 相册
    HWComposeToolbarButtonTypeMention, // @
    HWComposeToolbarButtonTypeTrend, // #
    HWComposeToolbarButtonTypeEmotion // 表情
}

protocol HWComposeToolbarDelegate:NSObjectProtocol{
    func composeToolbar(toolbar:HWComposeToolbar,didClickButton buttonType:HWComposeToolbarButtonType)
}

class HWComposeToolbar: UIView {
        

        
        var delegate:HWComposeToolbarDelegate?
        var emotionButton:UIButton!
    
    
//    - (void)setShowKeyboardButton:(BOOL)showKeyboardButton
//    {
//    _showKeyboardButton = showKeyboardButton;
//    
//    // 默认的图片名
//    NSString *image = @"compose_emoticonbutton_background";
//    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
//    
//    // 显示键盘图标
//    if (showKeyboardButton) {
//    image = @"compose_keyboardbutton_background";
//    highImage = @"compose_keyboardbutton_background_highlighted";
//    }
//    
//    // 设置图片
//    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//    [self.emotionButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
//    }

    
    var showKeyboardButton:Bool?{
        
        didSet{
            
            // 默认的图片名
            var image="compose_emoticonbutton_background"
            var highImage="compose_emoticonbutton_background_highlighted"
            
            // 显示键盘图标
            if(self.showKeyboardButton == true){
                image = "compose_keyboardbutton_background"
                highImage = "compose_keyboardbutton_background_highlighted"
            }
            
            // 设置图片
            self.emotionButton.setImage(UIImage(named: image), forState: UIControlState.Normal)
            self.emotionButton.setImage(UIImage(named: highImage), forState: UIControlState.Highlighted)
            
        }
        
    }
    
    
    
    
    
    
    
//    
//        /** 是否要显示键盘按钮  */
//        private var _showKeyboardButton:Bool?
//        var showKeyboardButton:Bool!{
//            get{
//                if(self._showKeyboardButton == nil){
//                    return false
//                }else{
//                    return self._showKeyboardButton!
//                }
//            }
//            set{
//                self._showKeyboardButton=newValue
//                // 默认的图片名
//                var image="compose_emoticonbutton_background"
//                var highImage="compose_emoticonbutton_background_highlighted"
//                
//                // 显示键盘图标
//                if(self.showKeyboardButton == true){
//                    image = "compose_keyboardbutton_background"
//                    highImage = "compose_keyboardbutton_background_highlighted"
//                }
//                
//                // 设置图片
//                self.emotionButton.setImage(UIImage(named: image), forState: UIControlState.Normal)
//                self.emotionButton.setImage(UIImage(named: highImage), forState: UIControlState.Highlighted)
//            }
//        }
//    

    

    

        override init(frame: CGRect) {
            super.init(frame: frame)
        
            self.backgroundColor=UIColor.RGB(246, 246, 246, 1)
                //UIColor(patternImage: UIImage(named: "compose_toolbar_background")!)
            // 初始化按钮
            self.setupBtn("compose_camerabutton_background", highImage: "compose_camerabutton_background_highlighted", type: HWComposeToolbarButtonType.HWComposeToolbarButtonTypeCamera)
            
            self.setupBtn("compose_toolbar_picture", highImage: "compose_toolbar_picture_highlighted", type: HWComposeToolbarButtonType.HWComposeToolbarButtonTypePicture)
            
            self.setupBtn("compose_mentionbutton_background", highImage: "compose_mentionbutton_background_highlighted", type: HWComposeToolbarButtonType.HWComposeToolbarButtonTypeMention)
            
            self.setupBtn("compose_trendbutton_background", highImage: "compose_trendbutton_background_highlighted", type: HWComposeToolbarButtonType.HWComposeToolbarButtonTypeTrend)
            
            self.emotionButton = self.setupBtn("compose_emoticonbutton_background", highImage: "compose_emoticonbutton_background_highlighted", type: HWComposeToolbarButtonType.HWComposeToolbarButtonTypeEmotion)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
    
    
    
        ///  创建一个按钮
        ///
        ///  - parameter image:     普通状态下的图片
        ///  - parameter highImage: 高亮状态下的图片
        ///  - parameter type:      按钮类型
        ///
        ///  - returns: 按钮
        func setupBtn(image:String,highImage:String,type:HWComposeToolbarButtonType)->UIButton{
            let btn=UIButton()
            btn.setImage(UIImage(named: image), forState: UIControlState.Normal)
            btn.setImage(UIImage(named: highImage), forState: UIControlState.Highlighted)
            btn.addTarget(self, action: "btnClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            btn.tag = type.rawValue
            self.addSubview(btn)
            return btn
        }
        
        func btnClicked(btn:UIButton){
            if(self.delegate != nil ){
                
                self.delegate!.composeToolbar(self, didClickButton: HWComposeToolbarButtonType(rawValue: btn.tag)!)
            }
        }
        
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            // 设置所有按钮的frame
            let count=self.subviews.count
            if(count == 0){
                return
            }
            let btnW:CGFloat=self.width / CGFloat(count)
            let btnH:CGFloat=self.height
            for i:Int in 0...count-1{
                let btn=self.subviews[i] as! UIButton
                btn.y=0
                btn.width=btnW
                btn.x = CGFloat(i) * btnW
                btn.height=btnH
            }
        }
}