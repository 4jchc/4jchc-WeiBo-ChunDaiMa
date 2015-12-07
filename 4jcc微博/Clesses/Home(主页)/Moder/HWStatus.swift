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
    var text:NSString?
    
    /**微博作者的用户信息字段 详细*/
    var user:HWUser?
    

 
    /** 微博配图地址。多图时返回多图链接。无配图返回“[]” */
    var pic_urls:NSArray?

    /** 被转发的原微博信息字段，当该微博为转发微博时返回 */
    var retweeted_status:HWStatus?
    
    
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
        
        // _created_at = @"Tue Sep 30 17:06:25 +0600 2014";
        
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
//        //    range.length = [source rangeOfString:@"<" options:NSBackwardsSearch];
//        self.source = "@来自\(source!.substringWithRange(range))"
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
    
    
    
    
    
    
        
        
        

    //MARK: - MJ的字典转模型
    override static func objectClassInArray() -> [NSObject : AnyObject]! {
        return ["user":HWUser.classForCoder(),"pic_urls":HWPhoto.classForCoder()]
    }
  

}
