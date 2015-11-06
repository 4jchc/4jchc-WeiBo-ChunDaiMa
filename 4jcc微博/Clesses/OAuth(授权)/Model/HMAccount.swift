//
//  HMAccount.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/6.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HMAccount: NSObject ,NSCoding{

    /**　string	用于调用access_token，接口获取授权后的access token。*/
    var access_token:NSString!
    
    /**　string	access_token的生命周期，单位是秒数。*/
    var expires_in:NSNumber!
    
    /**　string	当前授权用户的UID。*/
    var uid:NSString!
    
    /**	access token的创建时间 */
    var created_time:NSDate!
    
    
     override init() {
        super.init()
        
    }
    
    
    
    
   class func accountWithDict(dict:NSDictionary)->HMAccount{
        
        let account:HMAccount = HMAccount()
       
        account.access_token = dict["access_token"] as! NSString
        account.uid = dict["uid"] as! NSString
        account.expires_in = dict["expires_in"] as! NSNumber
        
        return account
        
    }

    ////*****✅/ MARK: - 归档&接档，如果不指定键名，会使用 属性名称作为 key
    // 如果写了归档和接档方法，至少需要有一个构造函数
    
    ///  解档方法，NSCoding 需要的方法 － required 的构造函数不能写在 extension 中
    ///  覆盖构造函数
    
    /**
    *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
    *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
    */
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
            self.access_token = aDecoder.decodeObjectForKey("access_token") as? String
            self.expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
            self.uid = aDecoder.decodeObjectForKey("uid") as? NSString
            self.created_time = aDecoder.decodeObjectForKey("created_time") as! NSDate
    }
    
    /**
    *  当一个对象要归档进沙盒中时，就会调用这个方法
    *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
    */
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(self.access_token, forKey: "access_token")
        aCoder.encodeObject(self.expires_in, forKey: "expires_in")
        aCoder.encodeObject(self.uid, forKey: "uid")
        aCoder.encodeObject(self.created_time, forKey: "created_time")
        
        print("*****我取模型了")
        

    }



    


}
