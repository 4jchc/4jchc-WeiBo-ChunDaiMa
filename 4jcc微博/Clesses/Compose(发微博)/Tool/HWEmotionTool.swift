//
//  HWEmotionTool.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWEmotionTool: NSObject {
    
    // 最近表情的存储路径
    static let HWRecentEmotionsPath:String = ((NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last)! as NSString).stringByAppendingPathComponent("emotions.archive")
    

    
    
    override class func initialize(){
        
        _recentEmotions = NSKeyedUnarchiver.unarchiveObjectWithFile(HWRecentEmotionsPath) as? NSMutableArray

        if (_recentEmotions == nil) {
            _recentEmotions = NSMutableArray()
        }
        
    }

    static func addRecentEmotion(emotion:HWEmotion){
        
        // 删除重复的表情
        _recentEmotions!.removeObject(emotion)
        
        // 将表情放到数组的最前面
        _recentEmotions!.insertObject(emotion,atIndex:0)
        
        // 将所有的表情数据写入沙盒
        NSKeyedArchiver.archiveRootObject(_recentEmotions! , toFile:HWRecentEmotionsPath)

    }

    /**
    *  返回装着HWEmotion模型的数组
    */
    static var _recentEmotions:NSMutableArray?
    static func recentEmotions()->NSMutableArray?{
        
        
        return _recentEmotions
    }

    // 加载沙盒中的表情数据
    //    NSMutableArray *emotions = (NSMutableArray *)[self recentEmotions];
    //    if (emotions == nil) {
    //        emotions = [NSMutableArray array];
    //    }
    
    //    [emotions removeObject:emotion];
    //    for (int i = 0; i<emotions.count; i++) {
    //        HWEmotion *e = emotions[i];
    //
    //        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code]) {
    //            [emotions removeObject:e];
    //            break;
    //        }
    //    }
    
    //    for (HWEmotion *e in emotions) {
    //        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code]) {
    //            [emotions removeObject:e];
    //            break;
    //        }
    //    }

    
    

}
