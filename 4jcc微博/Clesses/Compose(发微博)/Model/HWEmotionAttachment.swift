//
//  HWEmotionAttachment.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWEmotionAttachment: NSTextAttachment {
    
//    private var _emotion:HWEmotion?
//    var emotion:HWEmotion?{
//        get{
//            return self._emotion
//        }
//        set{
//            self._emotion=newValue
//            self.image=UIImage(named: newValue!.png!)
//        }
//    }

    var emotion:HWEmotion?{
        
        didSet{
            self.image=UIImage(named: emotion!.png! as String)
            
        }
    }
    
    
    
}
