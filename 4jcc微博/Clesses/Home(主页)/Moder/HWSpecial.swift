//
//  HWSpecial.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/7.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWSpecial: NSObject {

    /** 这段特殊文字的内容 */
    var text:NSString?
    /** 这段特殊文字的范围 */
    var range:NSRange?
    
    
    //-fno-objc-arc
}
///*****✅/  extension 是一个分类，分类不允许有存储能力
///  如果要打印对象信息，OC 中的 description，在 swift 中需要遵守协议 DebugPrintable
extension HWSpecial: CustomDebugStringConvertible {
    
    override var debugDescription: String {
        
        let dict = NSString(format: "%@ - %@", self.text!, NSStringFromRange(self.range!))
        return "\(dict)"
    }
}


