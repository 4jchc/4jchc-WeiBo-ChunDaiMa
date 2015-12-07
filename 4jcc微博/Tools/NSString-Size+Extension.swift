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

    

}