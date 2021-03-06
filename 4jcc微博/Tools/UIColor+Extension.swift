//
//  UIColor+Extension.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/1.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

///*****✅随机颜色color
extension UIColor {
    
//    class func randomColor() -> UIColor {
//        /*
//        颜色有两种表现形式 RGB RGBA
//        RGB 24
//        R,G,B每个颜色通道8位
//        8的二进制 255
//        R,G,B每个颜色取值 0 ~255
//        120 / 255.0
//        */
//        let r:CGFloat = CGFloat(arc4random_uniform(UInt32(256))) / 255.0
//        let g:CGFloat = CGFloat(arc4random_uniform(UInt32(256))) / 255.0
//        let b:CGFloat = CGFloat(arc4random_uniform(UInt32(256))) / 255.0
//        
//        return UIColor(red: r, green: g, blue: b, alpha: 1)
//    }
    
    // 随机色
    static var randomColor:UIColor{
        get{
            return UIColor(red: CGFloat(Double(arc4random_uniform(256))/255.0), green: CGFloat(Double(arc4random_uniform(256))/255.0), blue: CGFloat(Double(arc4random_uniform(256))/255.0), alpha: 1.0)
        }
        
    }
    

    //UIColor(red: <#123#>/255.0, green: <#123#>/255.0, blue: <#123#>/255.0, alpha: 1.0)
    
    class func RGB(r:CGFloat,_ g:CGFloat, _ b:CGFloat, _ alpha:CGFloat)->UIColor{
        
        
        return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: alpha)
    }
    
}


