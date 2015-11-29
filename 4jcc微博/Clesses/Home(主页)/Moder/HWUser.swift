//
//  HWUser.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/11/7.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit



class HWUser: NSObject {
    
    /**	string	字符串型的用户UID*/
    var idstr:NSString!

    /**	string	友好显示名称*/
    var name:NSString!
    
    /**	string	用户头像地址，50×50像素*/
    var profile_image_url:NSString!

    


    /** 会员类型 > 2代表是会员 */

    var mbtype:Int?{
        
        didSet{
            
            self.isVip = mbtype > 2
            
        }
    }
    /** 会员等级 */
    var mbrank:Int!
    
    var isVip:Bool?

    /// 根据用户vip等级来显示vip等级图标
    var vipImage:UIImage? {
        if mbrank > 0 && mbrank < 7 {
            return UIImage(named: "common_icon_membership_level\(mbrank)")
        } else {
            return UIImage(named: "common_icon_membership_expired")
        }
    }

    
    

}
