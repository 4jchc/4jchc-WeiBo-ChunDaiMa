//
//  HWHttpTool.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/3.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import Foundation

class HWHttpTool:NSObject{
    static func get(url:String,params:AnyObject?,success:(responseObject:AnyObject) -> Void,failure:(error:NSError) -> Void){
        // 1.创建管理者
        let mgr=AFHTTPRequestOperationManager()
        // 2.发送请求
        mgr.GET(url, parameters: params, success: { (operation, responseObject) -> Void in
            success(responseObject: responseObject)
            }) { (operation, error) -> Void in
                failure(error: error)
        }
    }
    static func post(url:String,params:AnyObject?,success:(responseObject:AnyObject) -> Void,failure:(error:NSError) -> Void){
        // 1.创建管理者
        let mgr=AFHTTPRequestOperationManager()
        //self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
        //mgr.responseSerializer.acceptableContentTypes = NSSet(objects: ["text/plain","application/json","text/json","text/javascript"]) as Set<NSObject>
        mgr.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain","application/json","text/json","text/javascript"])as Set<NSObject>
        // 2.发送请求
        mgr.POST(url, parameters: params, success: { (operation, responseObject) -> Void in
            success(responseObject: responseObject)
            }) { (operation, error) -> Void in
                failure(error: error)
        }
        
    }
    
    static func post(url:String,params:AnyObject?,constructingBodyBlock: (formData:AFMultipartFormData) -> Void,success:(responseObject:AnyObject) -> Void,failure:(error:NSError) -> Void){
        // 1.创建管理者
        let mgr=AFHTTPRequestOperationManager()
    
        mgr.POST(url, parameters: params, constructingBodyWithBlock: { (formData:AFMultipartFormData?) -> Void in
            
            constructingBodyBlock(formData: formData!)

            }, success: { (operation:AFHTTPRequestOperation?, responseObject) -> Void in
                success(responseObject: responseObject)
            }) { (operation:AFHTTPRequestOperation?, error) -> Void in
                failure(error: error)
        }
    }




}