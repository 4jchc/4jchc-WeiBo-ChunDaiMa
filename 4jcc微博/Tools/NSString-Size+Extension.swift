//
//  NSString+Extension.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/11/30.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit


extension NSString{

    //MARK: 💗根据字体设置高度
    func sizeWithText(text: String?, font: UIFont, maxSize: CGSize) -> CGSize{
        if text != nil  {
            
            let attrs: Dictionary = [NSFontAttributeName: font]
            
            let rect = text!.boundingRectWithSize(maxSize, options:NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attrs, context: nil)
            
            return rect.size;
            
        }
        return CGSizeZero;
    }
    
    
    
    func sizeWithFont(font: UIFont, maxW: CGFloat) -> CGSize {
        
        let attrs: Dictionary = [NSFontAttributeName: font]
        let maxSize: CGSize = CGSizeMake(maxW,CGFloat.max);
        let rect = self.boundingRectWithSize(maxSize, options:NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attrs, context: nil)
        return rect.size;
    
    }

        func fileSize()->Int{
        // 文件管理者
        let mgr: NSFileManager = NSFileManager.defaultManager()
        // 判断是否为文件
        var di: ObjCBool  = false;
        let exists: Bool = mgr.fileExistsAtPath(self as String, isDirectory: &di)

        // 文件\文件夹不存在
        if (exists == false) {return 0}
    
        if (di) { // self是一个文件夹
            // 遍历caches里面的所有内容 --- 直接和间接内容
            let subpaths: NSArray = mgr.subpathsAtPath(self as String)!
            var  totalByteSize:Int = 0;
            for subpath in subpaths {
                // 获得全路径
                let fullSubpath: NSString  = self.stringByAppendingPathComponent(subpath as! String)
                // 判断是否为文件
                var di:ObjCBool = true
                let exists: Bool = mgr.fileExistsAtPath(self as String, isDirectory: &di)
                if (exists == false) { // 文件
                let attributes: NSDictionary = try! mgr.attributesOfItemAtPath(fullSubpath as String)
                    
                
                    totalByteSize = totalByteSize + Int(attributes.fileSize())
                }
            }
            return totalByteSize;
        } else { // self是一个文件
            let attributes: NSDictionary = try! mgr.attributesOfItemAtPath(self as String)
            return Int(attributes.fileSize())
            
           
        }
    }

}