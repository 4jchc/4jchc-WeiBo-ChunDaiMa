//
//  HWEmotionButton.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWEmotionButton: UIButton {

//    private var _emotion:WBEmotion?
//    var emotion:WBEmotion!{
//        set{
//            self._emotion=newValue
//            if(newValue.png != nil){
//                // 有图片
//                self.setImage(UIImage(named: newValue.png!), forState: UIControlState.Normal)
//            }else if(newValue.code != nil){
//                // 是emoji表情
//                // 设置emoji
//                self.setTitle((newValue.code! as NSString).emoji() as String , forState: UIControlState.Normal)
//            }
//        }
//        get{
//            return self._emotion
//        }
//    }
    
    var emotion:HWEmotion?{
        
        didSet{
            
            if(emotion!.png != nil){
                // 有图片
                self.setImage(UIImage(named: emotion!.png! as String), forState: UIControlState.Normal)
            }else if(emotion!.code != nil){
                // 是emoji表情
                // 设置emoji
                self.setTitle((emotion!.code! as NSString).emoji() as String , forState: UIControlState.Normal)
            }
            
        }
        
    }
    
    
    
    
    
    
    
    /**
     *  当控件不是从xib、storyboard中创建时，就会调用这个方法
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    /**
     *  当控件是从xib、storyboard中创建时，就会调用这个方法
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    /**
     *  这个方法在initWithCoder:方法后调用
     */
    override func awakeFromNib() {
        
    }
    
    
    
    
    func setup(){
        self.titleLabel?.font=UIFont.systemFontOfSize(32)
        
        // 按钮高亮的时候。不要去调整图片（不要调整图片会灰色）
        self.adjustsImageWhenHighlighted=false
    }
    

}
