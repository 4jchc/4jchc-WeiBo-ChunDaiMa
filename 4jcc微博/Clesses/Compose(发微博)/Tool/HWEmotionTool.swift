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


    
    //通过表情描述 找到对应的表情模型
    class func emtionWithChs(chs: String) -> HWEmotion?{
        //遍历默认表情
        
        for  emotion in self.defaultEmotions{
            
            let emotion:HWEmotion = emotion as! HWEmotion
            if (emotion.chs! as NSString).isEqual(chs){
                return emotion
            }
        }
        
        //遍历浪小花
        for emotion in self.lxhEmotions{
            let emotion:HWEmotion = emotion as! HWEmotion
            if (emotion.chs! as NSString).isEqual(chs){
                return emotion
            }
        }
        
        return nil
    }

    
    
    //MARK: - 返回装着HWEmotion模型的数组
    /**
    *  返回装着HWEmotion模型的数组
    */
    static var _recentEmotions:NSMutableArray?
    static func recentEmotions()->NSMutableArray?{
        
        
        return _recentEmotions
    }
    
    static var defaultEmotions:NSArray! = {
        
        var ani = NSArray()
        let path=NSBundle.mainBundle().pathForResource("EmotionIcons/default/info.plist", ofType: nil)
       
        ani = HWEmotion.objectArrayWithKeyValuesArray(NSArray(contentsOfFile: path!))
       
        return ani
    }()
    //emoji表情集合
    static var emojiEmotions:NSArray! = {
        
        var ani = NSArray()
        let path=NSBundle.mainBundle().pathForResource("EmotionIcons/emoji/info", ofType: "plist")
        ani = HWEmotion.objectArrayWithFile(path)
        
        return ani

    }()
    //浪小花表情集合
    static var lxhEmotions:NSArray! = {
        
        var ani = NSArray()
        let path=NSBundle.mainBundle().pathForResource("EmotionIcons/lxh/info.plist", ofType: nil)
        ani = HWEmotion.objectArrayWithFile(path)
        
        return ani
    }()
    
    

    



    
    
    
}
