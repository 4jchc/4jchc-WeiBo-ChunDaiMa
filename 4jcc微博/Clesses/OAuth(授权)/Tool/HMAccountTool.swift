//
//  HMAccountTool.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/6.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HMAccountTool: NSObject {
    
    // 账号的存储路径
   static let  HMAccountPath = ((NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last)! as NSString).stringByAppendingPathComponent("account.archive")

    /**
    *  存储账号信息
    *
    *  @param account 账号模型
    */
   class func saveAccount(account:HMAccountModel){
        
    /// 获得账号存储的时间（accessToken的产生时间）

        account.created_time = NSDate()
    
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
        NSKeyedArchiver.archiveRootObject(account, toFile:HMAccountPath)

    }
    
    
    /**
    *  返回账号信息
    *
    *  @return 账号模型（如果账号过期，返回nil）
    */
   class func loadAccount() -> HMAccountModel?{
        
    // 加载模型
        let account = NSKeyedUnarchiver.unarchiveObjectWithFile(HMAccountPath) as? HMAccountModel
    
    /* 验证账号是否过期 */
    
    
    /// 判断是不是第一次打开应用.第一次没有加载数据所以为nil
    // 过期的秒数
    if account == nil {
        
        return nil
    }
    

    
        let expires_in:Int = account!.expires_in.integerValue
    
    /// 获得过期时间
        
    let expiresTime:NSDate = (account!.created_time).dateByAddingTimeInterval(Double(expires_in))
    
    
    
    // 获得当前时间
        let now:NSDate = NSDate()
        
        let result:NSComparisonResult = expiresTime.compare(now)
    
     print("***过期时间**\(expiresTime)***\(result)**\(now)**\(expires_in)")
    
    // 如果expiresTime <= now，过期
    /**
    NSOrderedAscending = -1L, 升序，右边 > 左边
    NSOrderedSame, 一样
    NSOrderedDescending 降序，右边 < 左边
    */
        
    if (result != NSComparisonResult.OrderedDescending) { // 过期
        
        return nil;
    }
    
        return account;
    }
    


}
