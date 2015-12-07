//
//  HWTextView.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWTextView: UITextView {

    let HWNotificationCenter=NSNotificationCenter.defaultCenter()
    //MARK: - set方法
//    private var _placeholder:String?
//    var placeholder:String?{
//        get{
//            return self._placeholder
//        }
//        set{
//            self._placeholder=newValue
//            self.setNeedsDisplay()
//        }
//    }
//    
//    private var _placeholderColor:UIColor?
//    var placeholderColor:UIColor?{
//        get{
//            return self._placeholderColor
//        }
//        set{
//            self._placeholderColor=newValue
//            self.setNeedsDisplay()
//        }
//    }
    
    
    var placeholderColor:UIColor?{
        
        didSet{
            self.setNeedsDisplay()
        }
    }
    var placeholder:String?{
        
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    
    
    
    
    //MARK: - 重写系统属性
    override var text:String?{
        get{
            return super.text
        }
        set{
            super.text=newValue
            // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
            self.setNeedsDisplay()
        }
    }
    
    override var attributedText:NSAttributedString?{
        get{
            return super.attributedText
        }
        set{
            super.attributedText=newValue
            self.setNeedsDisplay()
        }
    }
    
    
    override var font:UIFont?{
        get{
            return super.font
        }
        set{
            super.font=newValue
            self.setNeedsDisplay()
        }
    }
    
    //MARK: - 初始化
    init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        // 通知
        // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        HWNotificationCenter.addObserver(self, selector: "textDidChange", name: UITextViewTextDidChangeNotification, object: self)
        
    }
    
    deinit{
        HWNotificationCenter.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    //MARK: -  监听文字改变
    func textDidChange(){
        // 重绘（重新调用）
        self.setNeedsDisplay()
    }
    //MARK: - 画出占位符
    override func drawRect(rect: CGRect) {
        // 如果有输入文字，就直接返回，不画占位文字
        if(self.hasText()){
            return
        }
        
        // 文字属性
        var attrs=[String:AnyObject]()
        attrs[NSFontAttributeName]=self.font
        attrs[NSForegroundColorAttributeName] =  self.placeholderColor ??  UIColor.grayColor()

        // 画文字
        let x:CGFloat=5
        let w:CGFloat=rect.size.width - 2 * x
        let y:CGFloat=8
        let h:CGFloat=rect.size.height - 2*y
        let placeholderRect=CGRectMake(x, y, w, h)
        (self.placeholder! as NSString).drawInRect(placeholderRect, withAttributes: attrs)
    }

}
