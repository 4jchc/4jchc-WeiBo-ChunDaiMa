//
//  HWUser.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/11/7.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit



class HWUser: NSObject {
    

    enum HWUserVerifiedType:NSNumber {
        case None = -1 // 没有任何认证
        case Personal = 0  // 个人认证
        case OrgEnterprice = 2 // 企业官方：CSDN、EOE、搜狐新闻客户端
        case OrgMedia = 3 // 媒体官方：程序员杂志、苹果汇
        case OrgWebsite = 5 // 网站官方：猫扑
        case Daren = 220 // 微博达人
    }
    
    
    /**	string	字符串型的用户UID*/
    var idstr:NSString!

    /**	string	友好显示名称*/
    var name:NSString!
    
    /**	string	用户头像地址，50×50像素*/
    var profile_image_url:NSString!

    /** 会员类型 > 2代表是会员 */
    var mbtype:NSNumber?{
        
        didSet{
      
            self.isVip = mbtype?.integerValue > 2
            
        }
    }
    /** 会员等级 */
    var mbrank:NSNumber!
    
    var isVip:Bool?

//    /// 根据用户vip等级来显示vip等级图标
//    var vipImage:UIImage? {
//        if mbrank.integerValue > 0 && mbrank.integerValue < 7 {
//            return UIImage(named: "common_icon_membership_level\(mbrank)")
//        } else {
//            return UIImage(named: "common_icon_membership_expired")
//        }
//        
//    }
    

    /** 认证类型 */
    var verified_type:NSNumber?
    ///*****💗不用是枚举类型的直接是数字,枚举的类型是数字的就行
    //var verified_type:HWUserVerifiedType?

}
