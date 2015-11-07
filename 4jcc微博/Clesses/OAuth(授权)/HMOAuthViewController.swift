//
//  HMOAuthViewController.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/6.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit


//params["client_id"] = "1620692692";
//params["client_secret"] = "07f24cb123c91647e01b347eca27a5f7";
//params["grant_type"] = "authorization_code";
//params["redirect_uri"] = "http://www.baidu.com/";
//params["code"] = code; f407af7ed603b9ed0fe85b89fef510b8

/*
"access_token" = "2.00T53ksCiMQglBfca9810132k7niSC";
"expires_in" = 157679999;
"remind_in" = 157679999;
uid = 2641236981;
*/




class HMOAuthViewController: UIViewController,UIWebViewDelegate {

    
    let WB_API_URL_String       = "https://api.weibo.com/"
    let WB_Redirect_URL_String  = "http://www.baidu.com/"//没有/无法显示登录页面
    let WB_Client_ID            = "1620692692"
    let WB_Client_Secret        = "07f24cb123c91647e01b347eca27a5f7"
    let WB_Grant_Type           = "authorization_code"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

                    
        // 1.创建一个webView
        let webView:UIWebView = UIWebView()
        webView.frame = self.view.bounds;
        webView.delegate = self;
        self.view.addSubview(webView)

        // 2.用webView加载登录页面（新浪提供的）
        // 请求地址：https://api.weibo.com/oauth2/authorize
        /* 请求参数：
        client_id	true	string	申请应用时分配的AppKey。
        redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
        */
        let url:NSURL = NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(WB_Client_ID)&redirect_uri=\(WB_Redirect_URL_String)")!
        
        let request:NSURLRequest = NSURLRequest(URL: url)
        webView.loadRequest(request)
      
        }
    
    

    
    ///*****✅ #pragma mark - webView代理方法
    func webViewDidFinishLoad(webView: UIWebView) {
        MBProgressHUD.hideHUD()
        print("\(webViewDidFinishLoad)")
    }
    func webViewDidStartLoad(webView: UIWebView) {
        
        MBProgressHUD.showMessage("正在加载...")
         print("\(webViewDidStartLoad)")
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        MBProgressHUD.hideHUD()
    }
    
    
    
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        // 1.获得url
        let url:NSString = (request.URL?.absoluteString)!
       
        
        // 2.判断是否为回调地址
        let range:NSRange = url.rangeOfString("code=")

        if (range.length != 0) { // 是回调地址
            // 截取code=后面的参数值
            let fromIndex:Int = range.location + range.length
            let code:NSString = url.substringFromIndex(fromIndex)
         
            // 利用code换取一个accessToken
            self.accessTokenWithCode(code)
            print("*****\(code)")
           
        }
        
        return true
    }
    
    
    
    
    

    
    
    /**
    *  利用code（授权成功后的request token）换取一个accessToken
    *
    *  @param code 授权成功后的request token
    */
    func accessTokenWithCode(code:NSString){
        /*
        URL：https://api.weibo.com/oauth2/access_token
        
        请求参数：
        client_id：申请应用时分配的AppKey
        client_secret：申请应用时分配的AppSecret
        grant_type：使用authorization_code
        redirect_uri：授权成功后的回调地址
        code：授权成功后返回的code
        */
        // 1.请求管理者
        
        // 1.创建一个请求操作管理者
        let mgr:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        ///声明一下：服务器返回的是JSON数据
        mgr.responseSerializer = AFJSONResponseSerializer()

        // AFN的AFJSONResponseSerializer默认不接受text/plain这种类型
        
        // 2.拼接请求参数
        let params:NSMutableDictionary = NSMutableDictionary()
        
        params["client_id"] = "1620692692";
        params["client_secret"] = "07f24cb123c91647e01b347eca27a5f7";
        params["grant_type"] = "authorization_code";
        params["redirect_uri"] = "http://www.baidu.com/";
        params["code"] = code;
        
        // 3.发送请求
        
        mgr.POST("https://api.weibo.com/oauth2/access_token", parameters: params, success: { (_, responseObject ) -> Void in
            ///*****✅ success里的第二个就是字典---
            print("***请求成功-**\(responseObject)")
            MBProgressHUD.hideHUD()
            ///*****✅ 将返回的账号字典数据 --> 模型
            let account:HMAccountModel = HMAccountModel.accountWithDict(responseObject as! NSDictionary)
            ///*****✅ 存进沙盒存储账号信息
            HMAccountTool.saveAccount(account)
            
            /// 切换窗口的根控制器
            let window:UIWindow = UIApplication.sharedApplication().keyWindow!
            
            window.switchRootViewController()
  


            }) { (_, error) -> Void in
                
                MBProgressHUD.hideHUD()
                print("**请求失败**\(error)")
        }
    }




}














/////*****✅扩展

//extension ViewController: UIWebViewDelegate {
//
//    /// 页面重定向的函数
//    // iOS 中，如果代理方法有一个布尔型的返回值，如果返回 true，就能正常执行，false 就不正常工作
//    //CODE:71cc152f6319eba2daa508c4b30c206d
//
//    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//
//        if let code = requestCode(request.URL!) {
//
//            print("*****\(code)\r\n")
//            // 取 accesstoken
//            // 1. url
//            let urlString = "https://api.weibo.com/oauth2/access_token"
//            let url = NSURL(string: urlString)
//            let req = NSMutableURLRequest(URL: url!)
//
//            req.HTTPMethod = "POST"
//
//            // 定义 request 的请求参数
//            let bodyStr = "client_id=1620692692&client_secret=07f24cb123c91647e01b347eca27a5f7&redirect_uri=http://www.baidu.com/&grant_type=authorization_code&code=\(code)"
//            print("**\(bodyStr)\r\n")
//            req.HTTPBody = bodyStr.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
//
//            //req.HTTPBody = bodyStr.dataUsingEncoding(NSUTF8StringEncoding)
//
//            NSURLSession.sharedSession().dataTaskWithRequest(req as NSURLRequest , completionHandler: { (data, _, _) -> Void in
//
//               let dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
//
////                let dict: AnyObject?
////
////                do {
////                    dict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
////                } catch _ {
////
////                    dict = nil
////                }
//                print("*****\(dict)")
//
//            })!.resume()
//        }
//
//        return true
//    }
//
//
//
//    /// 从返回的地址中取到 code 内容
//    // 如果有 code 就返回，否则返回 nil
//    func requestCode(url: NSURL) -> String? {
//
//        // 1. 取出url中的字符串 url.query
//        print(url.absoluteString)
//        // 判断是否有 query 字符串query
//        if let query = url.query {
//            // 如果请求字符串中以code=开头
//            if query.hasPrefix("code=") {
//                // 取子串
//                let code:NSString = "code="
//                return (query as NSString).substringFromIndex(code.length)
//            }
//        }
//
//        return nil
//    }
//
//}

    




