//
//  HWStatus.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/11/7.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit


class HWStatus:NSObject {
    

    /**字符串型的微博ID*/
    var idstr:NSString?
    
    /**微博信息内容*/
    //MARK: set方法
    
    
    var text:NSString?{
        
        didSet{
            
            // 利用text生成attributedText
        self.attributedText = self.attributedTextWithText(text!)
            
        }
        
    }

    

    
    /**微博作者的用户信息字段 详细*/
    var user:HWUser?
    /**	string	微博信息内容 -- 带有属性的(特殊文字会高亮显示\显示表情)*/
    var attributedText:NSAttributedString?

 
    /** 微博配图地址。多图时返回多图链接。无配图返回“[]” */
    var pic_urls:NSArray?

    /** 被转发的原微博信息字段，当该微博为转发微博时返回 */
    //MARK: set方法
    var retweeted_status:HWStatus?{
        
        didSet{
            
            
            let retweetContent: NSString = "@\(retweeted_status!.user!.name) : \(retweeted_status!.text!)"
            //let retweetContent: NSString = NSString(format: @"@%@ : %@", retweeted_status!.user!.name, retweeted_status!.text!)
            self.retweetedAttributedText = self.attributedTextWithText(retweetContent)
    
        }
        
    }
    
    
    
    
    
    
    
    /**	被转发的原微博信息内容 -- 带有属性的(特殊文字会高亮显示\显示表情)*/
    var retweetedAttributedText:NSAttributedString?
    
    /**	int	转发数*/
    var reposts_count:NSNumber?
    /**	int	评论数*/
    var comments_count:NSNumber?
    /**	int	表态数*/
    var attitudes_count:NSNumber?
    

    
    
    /**
     1.今年
     1> 今天
     * 1分内： 刚刚
     * 1分~59分内：xx分钟前
     * 大于60分钟：xx小时前
     
     2> 昨天
     * 昨天 xx:xx
     
     3> 其他
     * xx-xx xx:xx
     
     2.非今年
     1> xxxx-xx-xx xx:xx
     */
     //计算属性(提供getter/setter)
     /**微博创建时间*/
    //var created_at: NSString?
    //MARK: - 微博创建时间的get方法
    
    private var _created_at:String!
    var created_at : NSString? {
        
        get{
         
            print("*****\("getfffffffffffffffff")")
  
        let fmt: NSDateFormatter  = NSDateFormatter()
        fmt.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy";
        // 如果是真机调试，转换这种欧美时间，需要设置locale
        fmt.locale = NSLocale(localeIdentifier: "en_US")
        
        // 设置日期格式（声明字符串里面每个数字和单词的含义）
        // E:星期几
        // M:月份
        // d:几号(这个月的第几天)
        // H:24小时制的小时
        // m:分钟
        // s:秒
        // y:年
        
        // _created_at = "Tue Sep 30 17:06:25 +0600 2014";
        
        // 微博的创建日期
        let createDate:NSDate = fmt.dateFromString(self._created_at as String)!
      
        // 当前时间
        let now: NSDate = NSDate()
        
        // 日历对象（方便比较两个日期之间的差距）
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        // NSCalendarUnit枚举代表想获得哪些差值
        let unit:NSCalendarUnit = [NSCalendarUnit.Year , NSCalendarUnit.Month , NSCalendarUnit.Day , NSCalendarUnit.Hour , NSCalendarUnit.Minute , NSCalendarUnit.Second]
        // 计算两个日期之间的差值
        let cmps:NSDateComponents = calendar.components(unit, fromDate: createDate, toDate: now, options: NSCalendarOptions())
        
        if createDate.isThisYear() == true { // 今年
            if createDate.isYesterday() { // 昨天
                fmt.dateFormat = "昨天 HH:mm";
                return fmt.stringFromDate(createDate)
                
            } else if createDate.isToday() { // 今天
                if (cmps.hour >= 1) {
                    return "\(cmps.hour)小时前"
                    
                } else if (cmps.minute >= 1) {
                    return "\(cmps.minute)分钟前"
                    
                } else {
                    return "刚刚"
                }
            } else { // 今年的其他日子
                fmt.dateFormat = "MM-dd HH:mm";
                return fmt.stringFromDate(createDate)
            }
        } else {
            // 非今年
            fmt.dateFormat="yyyy-MM-dd HH:mm"
            return fmt.stringFromDate(createDate)
            }
        }
        
        
        
        set{
            self._created_at=newValue as! String
        }
    }
    

    
        /**微博来源*/
        // source == <a href="http://app.weibo.com/t/feed/2llosp" rel="nofollow">OPPO_N1mini</a>
        //var source: NSString?
     
        ///*****✅一定要设置get方法可以判断为空
//     private var _source:String?
        //MARK: - 微博来源Set方法
//        var source: NSString?{
//        
//            set{
//        
//        // 正则表达式 NSRegularExpression
//        // 截串 NSString
//        var range = NSRange()
//        range.location = (source?.rangeOfString(">").location)! + 1
//           
//        range.length =  (source?.rangeOfString("</").location)! - range.location
//    
//        //    range.length = [source rangeOfString:"<" options:NSBackwardsSearch];
//        self.source = "来自\(source!.substringWithRange(range))"
//
//            }
//        get{
//            return self._source == nil ? "<a>未认证应用</a>" : self._source
//        }
//            
//        }
    
    
    
    
    /// 微博来源
    private var _source:String?
    var source:String!{
        get{
            return self._source == nil ? "<a>未认证应用</a>" : self._source
        }
        set{
            // 正则表达式 NSRegularExpression
            // 截串 NSString
            var sc=newValue
            if(sc==""){
                sc="<a>未认证应用</a>"
            }
            var range=NSRange()
            range.location=(sc as NSString).rangeOfString(">").location + 1
            range.length=(sc as NSString).rangeOfString("</").location-range.location
            let location=(sc as NSString).substringWithRange(range)
            self._source="来自\(location)"
        }
    }
    
    //MARK: - 正则表达式
    
    
    /**
    *  普通文字 --> 属性文字
    *
    *  param text 普通文字
    *
    *  return 属性文字
    */
    
    func attributedTextWithText(text:NSString) ->NSAttributedString{
        
        
        
        let attributedText: NSMutableAttributedString = NSMutableAttributedString()
        
        // 表情的规则
        let emotionPattern:NSString = "\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
        // @的规则
        let atPattern:NSString = "@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
        // #话题#的规则
        let topicPattern:NSString = "#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
        // url链接的规则
        let urlPattern:NSString = "\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
        
        let pattern:NSString = NSString(format: "%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern)
    
        
        // 遍历所有的特殊字符串
        let parts: NSMutableArray = NSMutableArray()
        
        
        //MARK: 匹配当前微博内容里面的表情字符串
        text.enumerateStringsMatchedByRegex(pattern as String, usingBlock: { (captureCount, captureString, capturedRanges, stop) -> Void in
    
                if (capturedRanges.memory).length == 0{
                    
                  return
                }
                print("*****匹配当前微博内容里面的表情字符串")
                let part: HWTextPart = HWTextPart()
                part.isSpecical = true
                part.text = captureString.memory! as NSString
            if part.text?.hasPrefix("[") == true && part.text?.hasSuffix("]") == true {
                
                part.isEmotion = true
            }
            
                part.range = capturedRanges.memory
                parts.addObject(part)
           
            })
            
        //MARK: 遍历所有的非特殊字符
        text.enumerateStringsSeparatedByRegex(pattern as String) { (captureCount, captureString, capturedRanges, stop) -> Void in
            
            if (capturedRanges.memory).length == 0{
                
                return
            }
            
            print("*****遍历所有的非特殊字符")
            let part: HWTextPart = HWTextPart()
            part.text = captureString.memory! as NSString
            part.range = capturedRanges.memory
            parts.addObject(part)
        
        }

        
        // 排序
        // 系统是按照从小 -> 大的顺序排列对象
        parts.sortUsingComparator{ (part1, part2) -> NSComparisonResult in
            let part1:HWTextPart = part1 as! HWTextPart
            let part2:HWTextPart = part2 as! HWTextPart
            let loc1 = part1.range!.location;
            let loc2 = part2.range!.location;
            
            if (loc1 <= loc2) {
                // part1>part2
                // part1放后面, part2放前面
                return NSComparisonResult.OrderedDescending;
            }
            // part1<part2
            // part1放前面, part2放后面
            return NSComparisonResult.OrderedAscending;
        }
        

        
        
        
        let font: UIFont = UIFont.systemFontOfSize(13.0)
        let specials: NSMutableArray = NSMutableArray()
        // 按顺序拼接每一段文字
        for part in parts {
            let part: HWTextPart = part as! HWTextPart
            // 等会需要拼接的子串
            var substr: NSAttributedString!
            if (part.isEmotion == true) { // 表情
                let attch: NSTextAttachment = NSTextAttachment()
                let name = HWEmotionTool.emtionWithChs(part.text as! String)?.png
               
                if ((name) != nil) { // 能找到对应的图片
                    //attch.image = UIImage(named: "d_aini")
                    attch.image = UIImage(named: name as! String)
                    attch.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                    substr = NSAttributedString(attachment: attch)
                    
                } else { // 表情图片不存在
                    substr = NSAttributedString(string: part.text as! String)
                }
            } else if (part.isSpecical == true) { // 非表情的特殊文字
                substr = NSAttributedString(string: part.text as! String, attributes: [NSForegroundColorAttributeName : UIColor.redColor()])

                // 创建特殊对象
                let s: HWSpecial = HWSpecial()
                s.text = part.text;
                let loc: Int  = attributedText.length;
                let len: Int = part.text!.length;
                s.range = NSMakeRange(loc, len);
                specials.addObject(s)
            } else { // 非特殊文字
                substr = NSAttributedString(string: part.text as! String)
            }
            attributedText.appendAttributedString(substr)
        }
        
        // 一定要设置字体,保证计算出来的尺寸是正确的
        attributedText.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, attributedText.length))
 
        attributedText.addAttribute("specials" ,value:specials ,range:NSMakeRange(0, 1))
        
        return attributedText;
    }
    

    
    
    


    
    
    
    
    
    

    //MARK: - MJ的字典转模型
    override static func objectClassInArray() -> [NSObject : AnyObject]! {
        return ["user":HWUser.classForCoder(),"pic_urls":HWPhoto.classForCoder()]
    }
  

}
