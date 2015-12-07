//
//  HWEmotion.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWEmotion: NSObject {


    /** 表情的文字描述 */
    var chs:NSString?
    /** 表情的png图片名 */
    var png:NSString?
    /** emoji表情的16进制编码 */
    var code:NSString?
    
    override init() {
        super.init()
    }
    
    ///  将一个对象从沙盒中解档
    ///
    ///  - parameter aDecoder:
    ///
    ///  - returns:
    required init(coder aDecoder: NSCoder) {
        self.chs=aDecoder.decodeObjectForKey("chs") as? String
        self.png=aDecoder.decodeObjectForKey("png") as? String
        self.code=aDecoder.decodeObjectForKey("code") as? String
    }
    ///  将一个对象归档到沙盒中
    ///
    ///  - parameter enCoder:
    func encodeWithCoder(enCoder: NSCoder) {
        enCoder.encodeObject(self.chs, forKey: "chs")
        enCoder.encodeObject(self.png, forKey: "png")
        enCoder.encodeObject(self.code, forKey: "code")
    }
    
    /**
     *  常用来比较两个HWEmotion对象是否一样
     *
     *  @param other 另外一个HWEmotion对象
     *
     *  @return YES : 代表2个对象是一样的，NO: 代表2个对象是不一样
     */  //MARK: - 重写isEqual方法判断是否文字相同
    override func isEqual(object: AnyObject?) -> Bool {
        let other:HWEmotion = object as! HWEmotion
        
//        if other.chs == nil || other.code == nil {
//            
//            return false
//        }
        if other.chs == nil {
            
            if other.code == nil {
                
                
                if self.png?.isEqualToString(other.png as! String) == true{
                    
                    return true
                }
            }
            
        }else if other.png == nil {
            
            if self.code?.isEqualToString(other.code as! String) == true{
                
                return true
            }

        }else {
            
            if self.chs?.isEqualToString(other.chs as! String) == true{
                
                return true
            }
            
        }
    return false
    }
    
        
        
        
        
//       if (self.chs?.isEqualToString((other.chs as? String)!)) == true || (self.png?.isEqualToString((other.png as? String)!) == true) || (self.code?.isEqualToString((other.code as? String)!) == true) {
//            
//            return true
//        } else{
//        
//            return false
//        }
    }
    
//    func isEqualTo(other: HWEmotion) -> Bool {
//        ///string
////        if((self.chs != nil && self.chs! == other.chs)
////        || (self.png != nil && self.png! == other.png)
////        || (self.code != nil && self.code! == other.code)){
////            return true
////        }else{
////            return false
////        }
//        
//       if (self.chs?.isEqualToString(other.chs as! String) == true) || (self.png?.isEqualToString(other.png as! String) == true) || (self.code?.isEqualToString(other.code as! String) == true) {
//            
//            return true
//        } else{
//            
//            return false
//        }
//   
//    }
//
//    
//}
