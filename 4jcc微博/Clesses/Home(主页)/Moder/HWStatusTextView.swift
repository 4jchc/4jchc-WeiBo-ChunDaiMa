//
//  HWStatusTextView.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/7.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

let HWStatusTextViewCoverTag =  999

class HWStatusTextView: UITextView {

    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.backgroundColor = UIColor.clearColor()
        self.editable = false
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        // 禁止滚动, 让文字完全显示出来
        self.scrollEnabled = false
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 触摸对象
        
        let touch:UITouch = (touches as NSSet).anyObject() as! UITouch
        
        // 获取当前的位置
        let point:CGPoint = touch.locationInView(self)
          //TODO:会报错
        let specials: NSArray  = self.attributedText.attribute("specials", atIndex: 0, effectiveRange: nil) as! NSArray
      
        var contains:Bool = false
            
        for special in specials {
            
                self.selectedRange = special.range
                // self.selectedRange --影响--> self.selectedTextRange
                // 获得选中范围的矩形框
            let rects: NSArray = self.selectionRectsForRange(self.selectedTextRange!)
                // 清空选中范围
                self.selectedRange = NSMakeRange(0, 0);
                
                for selectionRect in rects {
                    let rect: CGRect = selectionRect.rect;
                    if (rect.size.width == 0 || rect.size.height == 0) { continue }
                    
                    if (CGRectContainsPoint(rect, point)) { // 点中了某个特殊字符串
                        contains = true
                        break;
                    }
                }
                
                if (contains) {
                    for selectionRect in rects {
                        let rect: CGRect = selectionRect.rect;
                        if (rect.size.width == 0 || rect.size.height == 0) { continue }
                        
                        let cover: UIView  = UIView()
                        cover.backgroundColor = UIColor.greenColor()
                        cover.frame = rect;
                        cover.tag = HWStatusTextViewCoverTag;
                        cover.layer.cornerRadius = 5;
                        self.insertSubview(cover , atIndex:0)
                    }
                    
                    break;
                }
            }
            
            
            // 在被触摸的特殊字符串后面显示一段高亮的背景
        }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.25 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.touchesCancelled(touches, withEvent: event)
        }
    }

    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        // 去掉特殊字符串后面的高亮背景
        for child in self.subviews {
            
            
            if (child.tag == HWStatusTextViewCoverTag) {
                
                child.removeFromSuperview()
            }
        }
    }

    
    
    
    

    }


