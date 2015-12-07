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

// 被转发微博的正文字体
let HWStatusCellRetweetContentFont = UIFont.systemFontOfSize(13)

// cell之间的间距
let HWStatusCellMargin = 15


class HWStatusFrame: NSObject {
    

    /** 原创微博整体 */
    var originalViewF:CGRect?
    /** 头像 */
    var iconViewF:CGRect?
    /** 会员图标 */
    var vipViewF:CGRect?
    /** 配图 */
    var photosViewF:CGRect?
    /** 昵称 */
    var nameLabelF:CGRect?
    /** 时间 */
    var timeLabelF:CGRect?
    /** 来源 */
    var sourceLabelF:CGRect?
    /** 正文 */
    var contentLabelF:CGRect?
    
    /** 转发微博整体 */
    var retweetViewF:CGRect?
    /** 转发微博正文 + 昵称 */
    var retweetContentLabelF:CGRect?
    /** 转发配图 */
    var retweetPhotosViewF:CGRect?
    
    /** 底部工具条 */
    var toolbarF:CGRect?
    
    /** cell的高度 */
    var cellHeight:CGFloat?
    
    //MARK: - set
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
            let nameSize: CGSize = user.name.sizeWithFont(HWStatusCellNameFont, maxW: CGFloat.max)
            
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
            let timeSize:CGSize = (status!.created_at?.sizeWithFont(HWStatusCellTimeFont, maxW: CGFloat.max))!
           
            self.timeLabelF = CGRectMake(timeX, timeY,timeSize.width, timeSize.height)
            
            /** 来源 */
            let sourceX:CGFloat = CGRectGetMaxX(self.timeLabelF!) + HWStatusCellBorderW;
            let sourceY:CGFloat = timeY;
            let sourceSize: CGSize = status!.source!.sizeWithFont(HWStatusCellSourceFont, maxW: CGFloat.max)
  
            self.sourceLabelF = CGRectMake(sourceX, sourceY,sourceSize.width, sourceSize.height)
  
            
            
            
            /** 正文 */
            let contentX:CGFloat = iconX;
            let contentY:CGFloat = max(CGRectGetMaxY(self.iconViewF!), CGRectGetMaxY(self.timeLabelF!)) + HWStatusCellBorderW
          
            let maxW:CGFloat = cellW - 2 * contentX
            ///*****✅宽度要限制.不然不会换行.=屏幕的宽度-2个边距的宽度
            let contentSize:CGSize = status!.text!.sizeWithFont(HWStatusCellContentFont, maxW: maxW)
            

            self.contentLabelF = CGRectMake(contentX, contentY,contentSize.width, contentSize.height)
            
            
            /** 配图 */
            var originalH: CGFloat = 0;
            print("配图个数\(status!.pic_urls!.count)")
            if (status!.pic_urls!.count != 0) { // 有配图
                let photosX: CGFloat  = contentX;
                let photosY: CGFloat = CGRectGetMaxY(self.contentLabelF!) + HWStatusCellBorderW;
                let photosSize: CGSize = HWStatusPhotosView.sizeWithCount((status?.pic_urls!.count)!)
               
                self.photosViewF = CGRectMake(photosX, photosY, photosSize.width, photosSize.height)
                
                originalH = CGRectGetMaxY(self.photosViewF!) + HWStatusCellBorderW;
            } else { // 没配图
                originalH = CGRectGetMaxY(self.contentLabelF!) + HWStatusCellBorderW;
            }
            
            
            
            /** 原创微博整体 */
            let originalX:CGFloat = 0;
            let originalY:CGFloat = CGFloat(HWStatusCellMargin)
            let originalW:CGFloat = cellW;
            //let originalH:CGFloat = CGRectGetMaxY(self.contentLabelF!) + HWStatusCellBorderW;
            self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
            
            var toolbarY: CGFloat = 0;
            
            
          
            //MARK: - 被转发微博
            /* 被转发微博 */
            if (status!.retweeted_status != nil) {
                let retweeted_status: HWStatus  = status!.retweeted_status!;
                //print("*****\(retweeted_status.user!)")//TODO:如果微博被删会提示错误!
                let retweeted_status_user: HWUser = retweeted_status.user!
                
                
            /** 被转发微博正文 */
            let retweetContentX: CGFloat  = HWStatusCellBorderW;
            let retweetContentY: CGFloat  = HWStatusCellBorderW;
            let retweetContent: NSString = "@\(retweeted_status_user.name) : \(retweeted_status.text!)"
                
           // let retweetContent: NSString  = NSString(format: "@%@ : %@", retweeted_status_user.name, retweeted_status.text!)
            let retweetContentSize: CGSize = retweetContent.sizeWithFont(HWStatusCellRetweetContentFont, maxW: maxW)
                
            self.retweetContentLabelF = CGRectMake(retweetContentX, retweetContentY, retweetContentSize.width, retweetContentSize.height)

            

            
            /** 被转发微博配图 */
                
                var retweetH: CGFloat = 0;
                if (retweeted_status.pic_urls!.count != 0) { // // 转发微博有配图
                    let retweetPhotosX: CGFloat  = retweetContentX;
                    let retweetPhotosY: CGFloat = CGRectGetMaxY(self.retweetContentLabelF!) + HWStatusCellBorderW;
                    let retweetPhotosSize: CGSize = HWStatusPhotosView.sizeWithCount((retweeted_status.pic_urls!.count))
                    
                    self.retweetPhotosViewF = CGRectMake(retweetPhotosX, retweetPhotosY, retweetPhotosSize.width, retweetPhotosSize.height)
                    
                    retweetH = CGRectGetMaxY(self.retweetPhotosViewF!) + HWStatusCellBorderW;
                } else { // 没配图
                    retweetH = CGRectGetMaxY(self.retweetContentLabelF!) + HWStatusCellBorderW;
                }

                
            
                
                
            /** 被转发微博整体 */
                let retweetX:CGFloat = 0;
                let retweetY:CGFloat = CGRectGetMaxY(self.originalViewF!)
                let retweetW:CGFloat = cellW;
                //let originalH:CGFloat = CGRectGetMaxY(self.contentLabelF!) + HWStatusCellBorderW;
                self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);


                    toolbarY = CGRectGetMaxY(self.retweetViewF!);
                } else {
                    toolbarY = CGRectGetMaxY(self.originalViewF!);
                }
                    
            
            
            /** 工具条 */
            let toolbarX: CGFloat = 0;
            let toolbarW: CGFloat  = cellW;
            let toolbarH: CGFloat  = 35;
            self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
            
            /* cell的高度 */
            self.cellHeight = CGRectGetMaxY(self.toolbarF!);
                
            
                
            }

        }
        
    }
    
    
    
    

