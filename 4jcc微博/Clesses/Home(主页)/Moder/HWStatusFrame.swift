//
//  HWStatusFrame.swift
//  4j成才-微博
//
//  Created bY:CGFloat 蒋进 on 15/11/29.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit
//  一个HWStatusFrame模型里面包含的信息
//  1.存放着一个cell内部所有子控件的frame数据
//  2.存放一个cell的高度
//  3.存放着一个数据模型HWStatus

class HWStatusFrame: NSObject {
    
    
    // cell的边框宽度
    let HWStatusCellBorderW:CGFloat = 10
    // 昵称字体
    let HWStatusCellNameFont = UIFont.systemFontOfSize(15)
    // 时间字体
    let HWStatusCellTimeFont = UIFont.systemFontOfSize(12)
    // 来源字体
    let HWStatusCellSourceFont = UIFont.systemFontOfSize(12)
    // 正文字体
    let HWStatusCellContentFont = UIFont.systemFontOfSize(14)
    
    /** 原创微博整体 */
    var originalViewF:CGRect?
    /** 头像 */
    var iconViewF:CGRect?
    /** 会员图标 */
    var vipViewF:CGRect?
    /** 配图 */
    var photoViewF:CGRect?
    /** 昵称 */
    var nameLabelF:CGRect?
    /** 时间 */
    var timeLabelF:CGRect?
    /** 来源 */
    var sourceLabelF:CGRect?
    /** 正文 */
    var contentLabelF:CGRect?
    
    /** cell的高度 */
    var  cellHeight:CGFloat?
    
    
    
    
    
    
    //MARK: 💗根据字体设置高度
     func sizeWithText(text: String?, font: UIFont, maxSize: CGSize) -> CGSize{
        if text != nil  {
            
            let attrs: Dictionary = [NSFontAttributeName: font]
            
            let rect = text!.boundingRectWithSize(maxSize, options:NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attrs, context: nil)
            
            return rect.size;
            
        }
        return CGSizeZero;
    }

    
    
    
    var status:HWStatus?{
        
        didSet{
            
            let user = status!.user! as HWUser
            
            // cell的宽度
            let cellW:CGFloat = UIScreen.mainScreen().bounds.size.width;
            
            /* 原创微博 */
            
            /** 头像 */
            let iconWH:CGFloat = 35;
            let iconX:CGFloat = HWStatusCellBorderW;
            let iconY:CGFloat = HWStatusCellBorderW;
            self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);

            /** 昵称 */
            let nameX:CGFloat = CGRectGetMaxX(self.iconViewF!) + HWStatusCellBorderW;
            let nameY:CGFloat = iconY;
            let nameSize: CGSize = self.sizeWithText(user.name as String, font: HWStatusCellNameFont, maxSize:CGSizeMake(CGFloat.max, CGFloat.max) )
            
            self.nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height)
    
            /** 会员图标 */
            
            if user.isVip == true {
                let vipX:CGFloat = CGRectGetMaxX(self.nameLabelF!) + HWStatusCellBorderW;
                let vipY:CGFloat = nameY;
                let vipH:CGFloat = nameSize.height;
                let vipW:CGFloat = 14;
                self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
            }
            
            /** 时间 */
            let timeX:CGFloat = nameX;
            let timeY:CGFloat = CGRectGetMaxY(self.nameLabelF!) + HWStatusCellBorderW;
            let timeSize:CGSize = self.sizeWithText(user.name as String, font: HWStatusCellNameFont, maxSize:CGSizeMake(CGFloat.max, CGFloat.max) )
            self.timeLabelF = CGRectMake(timeX, timeY,timeSize.width, timeSize.height)
            
            /** 来源 */
            let sourceX:CGFloat = CGRectGetMaxX(self.timeLabelF!) + HWStatusCellBorderW;
            let sourceY:CGFloat = timeY;
            let sourceSize: CGSize = self.sizeWithText(user.name as String, font: HWStatusCellSourceFont, maxSize:CGSizeMake(CGFloat.max, CGFloat.max) )
  
            self.sourceLabelF = CGRectMake(sourceX, sourceY,sourceSize.width, sourceSize.height)
  
            
            /** 正文 */
            let contentX:CGFloat = iconX;
            let contentY:CGFloat = max(CGRectGetMaxY(self.iconViewF!), CGRectGetMaxY(self.timeLabelF!)) + HWStatusCellBorderW
          
            let maxW:CGFloat = cellW - 2 * contentX
            let contentSize:CGSize = self.sizeWithText(status!.text as? String, font: HWStatusCellContentFont, maxSize:CGSizeMake(maxW, CGFloat.max) )

            self.contentLabelF = CGRectMake(contentX, contentY,contentSize.width, contentSize.height)
            
            
            /** 配图 */
            
            /** 原创微博整体 */
            let originalX:CGFloat = 0;
            let originalY:CGFloat = 0;
            let originalW:CGFloat = cellW;
            let originalH:CGFloat = CGRectGetMaxY(self.contentLabelF!) + HWStatusCellBorderW;
            self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
            
            
            self.cellHeight = CGRectGetMaxY(self.originalViewF!);
        }

            
        }
        
    }
    
    
    
    

