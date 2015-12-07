//
//  HWEmotionPageView.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

// 账号信息
let HWAppKey = "3235932662";
let HWRedirectURI = "http://www.baidu.com";
let HWAppSecret = "227141af66d895d0dd8baca62f73b700";

// 通知
// 表情选中的通知
let HWEmotionDidSelectNotification = "HWEmotionDidSelectNotification";
let HWSelectEmotionKey = "HWSelectEmotionKey";

// 通知中心
let HWNotificationCenter = NSNotificationCenter.defaultCenter()

// 删除文字的通知
let HWEmotionDidDeleteNotification = "HWEmotionDidDeleteNotification";
// 一页中最多3行
let HWEmotionMaxRows = 3
// 一行中最多7列
let HWEmotionMaxCols = 7
// 每一页的表情个数
let HWEmotionPageSize = ((HWEmotionMaxRows * HWEmotionMaxCols) - 1)


class HWEmotionPageView: UIView {

    /** 点击表情后弹出的放大镜 */
    lazy var popView:HWEmotionPopView=HWEmotionPopView.popView()
    /** 删除按钮 */
    weak var deleteButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 1.删除按钮
        let deleteBtn=UIButton()
        deleteBtn.setImage(UIImage(named: "compose_emotion_delete_highlighted"), forState: UIControlState.Highlighted)
        deleteBtn.setImage(UIImage(named: "compose_emotion_delete"), forState: UIControlState.Normal)
        deleteBtn.addTarget(self, action: "deleteClicked", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(deleteBtn)
        self.deleteButton=deleteBtn
        
        // 2.添加长按手势
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: "longPressPageView:"))
        
    }
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    /** 这一页显示的表情（里面都是HWEmotion模型） */
    private var _emotions:NSArray?
    var emotions:NSArray!{
        get{
            return self._emotions == nil ? NSArray():self._emotions!
        }
        set{
            self._emotions=newValue
            let count=newValue.count
            if(0 == count){
                return
            }
            for i:Int in 0...count-1{
                let btn=HWEmotionButton()
                self.addSubview(btn)
                // 设置表情数据
                btn.emotion=newValue[i] as? HWEmotion
                // 监听按钮点击
                btn.addTarget(self, action: "btnClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            }
        }
    }
    
    
    
    
    
    
    
    
    

    
    ///  监听删除按钮点击
    func deleteClicked(){
        HWNotificationCenter.postNotificationName(HWEmotionDidDeleteNotification, object: nil)
    }
    
    
    ///  监听表情按钮点击
    ///
    ///  - parameter btn: 被点击的表情按钮
    func btnClicked(btn:HWEmotionButton){
        // 显示popView
        self.popView.showFrom(btn)
        
        // 等会让popView自动消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_MSEC) * 250), dispatch_get_main_queue(), { () -> Void in
            self.popView.removeFromSuperview()
        })
        
        // 发出通知
        self.selectEmotion(btn.emotion!)
    }
    

    
    
    
    
    
    
    
    
    
    
    ///  根据手指位置所在的表情按钮
    ///
    ///  - parameter location: 手指的位置
    func emotionButtonWithLocation(location:CGPoint)->HWEmotionButton?{
        if(self.emotions == nil){
            return nil
        }
        let count=self.emotions!.count
        for i:Int in 0...count-1{
            let btn=self.subviews[i+1] as! HWEmotionButton
            if(CGRectContainsPoint(btn.frame, location)){
                // 已经找到手指所在的表情按钮了，就没必要再往下遍历
                return btn
            }
        }
        return nil
    }
    
    
    ///  在这个方法中处理长按手势
    ///
    ///  - parameter recognizer: 手势
    func longPressPageView(recognizer:UILongPressGestureRecognizer){
        
        let location=recognizer.locationInView(recognizer.view)
        // 获得手指所在的位置\所在的表情按钮
        let btn=self.emotionButtonWithLocation(location)
        
        switch(recognizer.state){
        case UIGestureRecognizerState.Cancelled,UIGestureRecognizerState.Ended:
            // 手指已经不再触摸pageView
            // 移除popView
            self.popView.removeFromSuperview()
            
            // 如果手指还在表情按钮上
            if(btn != nil){
                // 发出通知
                self.selectEmotion(btn!.emotion!)
            }
            break
        case UIGestureRecognizerState.Began,UIGestureRecognizerState.Changed:
            // 手势开始（刚检测到长按）
            // 手势改变（手指的位置改变）
            self.popView.showFrom(btn)
            break
        default:
            break
        }
    }
    
    
    ///  选中某个表情，发出通知
    ///
    ///  - parameter emotion: 被选中的表情
    func selectEmotion(emotion:HWEmotion){
        // 将这个表情存进沙盒
        HWEmotionTool.addRecentEmotion(emotion)
        
        // 发出通知
        var userInfo=[String : AnyObject]()
        userInfo[HWSelectEmotionKey]=emotion
        HWNotificationCenter.postNotificationName(HWEmotionDidSelectNotification, object: nil, userInfo: userInfo)
    }
    
    
    
    
    // CUICatalog: Invalid asset name supplied: (null), or invalid scale factor: 2.000000
    // 警告原因：尝试去加载的图片不存在
    override func layoutSubviews() {
        super.layoutSubviews()
        // 内边距（四周）
        let inset:CGFloat=20
        let count=self.emotions.count
        let btnW:CGFloat=(self.frame.size.width - 2*inset) / CGFloat(HWEmotionMaxCols)
        let btnH=(self.frame.size.height - inset) / CGFloat(HWEmotionMaxRows)
        for i:Int in 0...count-1{
            let btn=self.subviews[i+1] as! HWEmotionButton
            btn.frame.size.width=btnW
            btn.frame.size.height=btnH
            btn.frame.origin.x=inset+CGFloat(i % HWEmotionMaxCols) * btnW
            btn.frame.origin.y=inset+CGFloat(i / HWEmotionMaxCols) * btnH
        }
        
        // 删除按钮
        self.deleteButton.frame.size.width=btnW
        self.deleteButton.frame.size.height=btnH
        self.deleteButton.frame.origin.y=self.frame.size.height-btnH
        self.deleteButton.frame.origin.x=self.frame.size.width-inset-btnW
    }

}
