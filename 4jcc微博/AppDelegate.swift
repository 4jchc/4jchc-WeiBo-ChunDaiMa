//
//  AppDelegate.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var task: UIBackgroundTaskIdentifier?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        sendNotification()
        // 1.创建窗口
    
        self.window = UIWindow()
        
        self.window!.frame = UIScreen.mainScreen().bounds
        
        // 2.设置根控制器
       
//        self.window!.rootViewController = HWTabBarViewController()

        if  HMAccountTool.loadAccount() != nil {

         // 之前已经登录成功过
            self.window?.switchRootViewController()
            
        } else {
           
            //授权页面
            self.window!.rootViewController = HMOAuthViewController()
        }
        
        // 3.显示窗口

        // 很多重复代码 ---> 将重复代码抽取到一个方法中
        // 1.相同的代码放到一个方法中
        // 2.不同的东西变成参数
        // 3.在使用到这段代码的这个地方调用方法， 传递参数

        self.window?.makeKeyAndVisible()
        
        return true
        }
//MARK: 💗 因为在IOS8中要想设置applicationIconBadgeNumber，需要用户的授权，在IOS8中，需要加上下面的代码：
    func sendNotification(){
        
        /// 注意: 在iOS8中, 必须提前注册通知类型
        if (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0{
            // 不是iOS8
            // 当用户第一次启动程序时就获取deviceToke
            // 该方法在iOS8以及过期了
            // 只要调用该方法, 系统就会自动发送UDID和当前程序的Bunle ID到苹果的APNs服务器
            let types: UIUserNotificationType = [.Alert, .Badge, .Sound]
            
            let pushSettings = UIUserNotificationSettings(forTypes: types, categories: nil)
            /// 注册通知类型
            UIApplication.sharedApplication().registerUserNotificationSettings(pushSettings)
            /// 申请试用通知
            UIApplication.sharedApplication().registerForRemoteNotifications()
            
        }
        
    }
    
    
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    /**
     *  当app进入后台时调用
     */
    func applicationDidEnterBackground(application: UIApplication) {
        /**
        *  app的状态
        *  1.死亡状态：没有打开app
        *  2.前台运行状态
        *  3.后台暂停状态：停止一切动画、定时器、多媒体、联网操作，很难再作其他操作
        *  4.后台运行状态
        */
        // 向操作系统申请后台运行的资格，能维持多久，是不确定的
        //MARK:💗方法1
//        var result = UIBackgroundTaskInvalid
//        result = application.beginBackgroundTaskWithExpirationHandler { () -> Void in
//            // 当申请的后台运行时间已经结束（过期），就会调用这个block
//            
//            // 赶紧结束任务
//            application.endBackgroundTask(result)
//            result = UIBackgroundTaskInvalid
//        }
        //***💗方法2
        
        task = application.beginBackgroundTaskWithExpirationHandler({
            
            application.endBackgroundTask(self.task!)
        })
        
        // 在Info.plst中设置后台模式：Required background modes == App plays audio or streams audio/video using AirPlay
        // 搞一个0kb的MP3文件，没有声音
        // 循环播放
        
        // 以前的后台模式只有3种
        // 保持网络连接
        // 多媒体应用
        // VOIP:网络电话   
  
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    
    //MARK: - 清除内存中的所有图片
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        
        let mgr: SDWebImageManager  = SDWebImageManager.sharedManager()
        // 1.取消下载
        mgr.cancelAll()
        
        // 2.清除内存中的所有图片
        mgr.imageCache.clearMemory()
    }
    
    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "swift._jcc__" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("_jcc__", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

