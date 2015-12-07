//
//  HWEmotionTabBar.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//


enum HWEmotionTabBarButtonType:Int{
    case HWEmotionTabBarButtonTypeRecent, // 最近
    HWEmotionTabBarButtonTypeDefault, // 默认
    HWEmotionTabBarButtonTypeEmoji, // emoji
    HWEmotionTabBarButtonTypeLxh // 浪小花
}

protocol HWEmotionTabBarDelegate:NSObjectProtocol{
    func emotionTabBar(tabBar:HWEmotionTabBar,didSelectButton buttonType:HWEmotionTabBarButtonType)
}
    
    
    class HWEmotionTabBar: UIView {
        
        
        weak var selectedBtn:HWEmotionTabBarButton?
        
//        private var _delegate:HWEmotionTabBarDelegate?
//        var delegate:HWEmotionTabBarDelegate?{
//            get{
//                return self._delegate
//            }
//            set{
//                self._delegate=newValue
//                
//                // 选中“默认”按钮
//                self.btnClicked(self.viewWithTag(HWEmotionTabBarButtonType.HWEmotionTabBarButtonTypeDefault.rawValue) as! HWEmotionTabBarButton)
//            }
//        }
        
        
        //MARK: 代理的set方法
        var delegate:HWEmotionTabBarDelegate?{
            
            didSet{
                
                // 选中“默认”按钮
                self.btnClicked(self.viewWithTag(HWEmotionTabBarButtonType.HWEmotionTabBarButtonTypeDefault.rawValue) as! HWEmotionTabBarButton)
                
            }
            
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.setupBtn("最近", buttonType: HWEmotionTabBarButtonType.HWEmotionTabBarButtonTypeRecent)
            self.setupBtn("默认", buttonType: HWEmotionTabBarButtonType.HWEmotionTabBarButtonTypeDefault)
            self.setupBtn("Emoji", buttonType: HWEmotionTabBarButtonType.HWEmotionTabBarButtonTypeEmoji)
            self.setupBtn("浪小花", buttonType: HWEmotionTabBarButtonType.HWEmotionTabBarButtonTypeLxh)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        ///  创建一个按钮
        ///
        ///  - parameter title:      按钮文字
        ///  - parameter buttonType: 按钮类型
        func setupBtn(title:String,buttonType:HWEmotionTabBarButtonType)->HWEmotionTabBarButton{
            // 创建按钮
            let btn=HWEmotionTabBarButton()
            btn.addTarget(self, action: "btnClicked:", forControlEvents: UIControlEvents.TouchDown)
            btn.tag=buttonType.rawValue
            btn.setTitle(title, forState: UIControlState.Normal)
            self.addSubview(btn)
            
            // 设置背景图片
            var image="compose_emotion_table_mid_normal"
            var selectImage="compose_emotion_table_mid_selected"
            if(self.subviews.count == 1){
                image="compose_emotion_table_left_normal"
                selectImage="compose_emotion_table_left_selected"
            }else if(self.subviews.count==4){
                image="compose_emotion_table_right_normal"
                selectImage="compose_emotion_table_right_selected"
            }
            
            btn.setBackgroundImage(UIImage(named: image), forState: UIControlState.Normal)
            btn.setBackgroundImage(UIImage(named: selectImage), forState: UIControlState.Disabled)
            return btn
        }
        
        ///  按钮点击
        ///
        ///  - parameter btn: 按钮
        func btnClicked(btn:HWEmotionTabBarButton){
            if(self.selectedBtn != nil){
                self.selectedBtn!.enabled=true
            }
            btn.enabled=false
            self.selectedBtn=btn
            
            // 通知代理
            if(self.delegate != nil){
                self.delegate!.emotionTabBar(self, didSelectButton: HWEmotionTabBarButtonType(rawValue: btn.tag)!)
            }
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            // 设置按钮的frame
            let btnCount=self.subviews.count
            let btnW:CGFloat=self.frame.size.width / CGFloat(btnCount)
            let btnH:CGFloat=self.frame.size.height
            for i:Int in 0...btnCount-1{
                let btn=self.subviews[i] as! HWEmotionTabBarButton
                btn.frame.origin.y=0
                btn.frame.size.width=btnW
                btn.frame.origin.x=CGFloat(i)*btnW
                btn.frame.size.height=btnH
            }
        }
}
