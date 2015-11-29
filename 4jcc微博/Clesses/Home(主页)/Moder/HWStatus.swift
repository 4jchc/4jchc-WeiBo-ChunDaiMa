//
//  HWStatus.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/11/7.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit


class HWStatus:NSObject {
    

    /**	string	字符串型的微博ID*/
    var idstr:NSString?
    
    /**	string	微博信息内容*/
    var text:NSString?
    
    /**	object	微博作者的用户信息字段 详细*/
    var user:HWUser?
    

    
    /**	string	微博创建时间*/
    var created_at: NSString?
    
    /**	string	微博来源*/
    var source: NSString?

    
    
    
    
//    class func statusWithDict(dict:NSDictionary)->HWStatus{
//        
//        let status:HWStatus = HWStatus()
//    
//        status.idstr = dict["idstr"] as! String
//        status.text = dict["text"] as! NSString
//        status.user = HWUser.userWithDict(dict["user"] as! NSDictionary)
//        return status
//    }
  
//    override static func objectClassInArray() -> [NSObject : AnyObject]! {
//        return ["img":"DetailImgModel"]
//    }
    override static func objectClassInArray() -> [NSObject : AnyObject]! {
        return ["user":HWUser.classForCoder()]
    }
  

//    class HWUser: NSObject {
//        
//        /**	string	字符串型的用户UID*/
//        var idstr:NSString!
//        
//        /**	string	友好显示名称*/
//        var name:NSString!
//        
//        /**	string	用户头像地址，50×50像素*/
//        var profile_image_url:NSString!
//
//    }
}
