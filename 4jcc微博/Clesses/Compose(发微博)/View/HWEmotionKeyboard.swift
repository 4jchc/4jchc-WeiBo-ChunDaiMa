//
//  HWEmotionKeyboard.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//


    //  表情键盘（整体）: HWEmotionListView + HWEmotionTabBar
    
import UIKit

class HWEmotionKeyboard: UIView,HWEmotionTabBarDelegate {
        
        
        //MARK: - 懒加载
        /** 保存正在显示listView */
        var showingListView:HWEmotionListView?
        /** 表情内容 */
//        private var _recentListView:HWEmotionListView?
//        var recentListView:HWEmotionListView!{
//            get{
//                if(self._recentListView == nil){
//                    self._recentListView = HWEmotionListView()
//                    // 加载沙盒中的数据
//                    self._recentListView!.emotions=HWEmotionTool.recentEmotions()
//                }
//                return self._recentListView!
//            }
//            set{
//                self._recentListView=newValue
//            }
//        }
        
        lazy var recentListView:HWEmotionListView! = {
            
            let ani = HWEmotionListView()
            // 加载沙盒中的数据
            ani.emotions=HWEmotionTool.recentEmotions()
            return ani
        }()

        lazy var defaultListView:HWEmotionListView! = {
            
            var ani = HWEmotionListView()
            // 加载沙盒中的数据
            ani.emotions = HWEmotionTool.defaultEmotions
           
            return ani
        }()
    
        lazy var emojiListView:HWEmotionListView! = {
            
            let ani = HWEmotionListView()
            // 加载沙盒中的数据
            ani.emotions = HWEmotionTool.emojiEmotions
            return ani
        }()
        
        lazy var lxhListView:HWEmotionListView! = {
            
            let ani = HWEmotionListView()
            // 加载沙盒中的数据
            ani.emotions = HWEmotionTool.lxhEmotions
            return ani
        }()
    
    
    
    
    
    
    
    
    
    
        
        
//        private var _defaultListView:HWEmotionListView?
//        var defaultListView:HWEmotionListView!{
//            get{
//                if(self._defaultListView==nil){
//                    self.defaultListView=HWEmotionListView()
//                    let path=NSBundle.mainBundle().pathForResource("EmotionIcons/default/info.plist", ofType: nil)
//                    self._defaultListView!.emotions=HWEmotion.objectArrayWithKeyValuesArray(NSArray(contentsOfFile: path!))
//                    
//                }
//                return self._defaultListView!
//            }
//            set{
//                self._defaultListView=newValue
//            }
//        }
        
//        private var _emojiListView:HWEmotionListView?
//        var emojiListView:HWEmotionListView!{
//            get{
//                if(self._emojiListView == nil){
//                    self._emojiListView = HWEmotionListView()
//                    let path=NSBundle.mainBundle().pathForResource("EmotionIcons/emoji/info", ofType: "plist")
//                    self._emojiListView!.emotions=HWEmotion.objectArrayWithKeyValuesArray(NSArray(contentsOfFile: path!))
//                }
//                return self._emojiListView!
//            }
//            set{
//                self._emojiListView=newValue
//            }
//        }
//        private var _lxhListView:HWEmotionListView?
//        var lxhListView:HWEmotionListView!{
//            get{
//                if(self._lxhListView == nil){
//                    self._lxhListView = HWEmotionListView()
//                    let path=NSBundle.mainBundle().pathForResource("EmotionIcons/lxh/info.plist", ofType: nil)
//                    self._lxhListView!.emotions=HWEmotion.objectArrayWithKeyValuesArray(NSArray(contentsOfFile: path!))
//                }
//                return self._lxhListView!
//            }
//            set{
//                self._lxhListView=newValue
//            }
//        }
        
        
        
        
        
        
        
        
        
        
        
        
        /** tabbar */
        var tabBar:HWEmotionTabBar!
        //MARK: - 初始化
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            let tabBar=HWEmotionTabBar()
            tabBar.delegate=self
            self.addSubview(tabBar)
            self.tabBar=tabBar
            
            // 监听表情选中的通知
            HWNotificationCenter.addObserver(self, selector: "emotionDidSelect", name: HWEmotionDidSelectNotification, object: nil)
        }
        
        deinit{
            HWNotificationCenter.removeObserver(self)
        }
        
        func emotionDidSelect(){
            self.recentListView.emotions=HWEmotionTool.recentEmotions()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            // 1.tabbar
            self.tabBar.width=self.width
            self.tabBar.height=37
            self.tabBar.x=0
            self.tabBar.y=self.height-self.tabBar.height
            
            // 2.表情内容
            if(self.showingListView != nil){
                self.showingListView!.x=0
                self.showingListView!.y=0
                self.showingListView!.width=self.width
                self.showingListView!.height=self.tabBar.y
            }
        }
        //MARK: - HWEmotionTabBarDelegate
        func emotionTabBar(tabBar: HWEmotionTabBar, didSelectButton buttonType: HWEmotionTabBarButtonType) {
            // 移除正在显示的listView控件
            if(self.showingListView != nil){
                self.showingListView!.removeFromSuperview()
            }
            
            // 根据按钮类型，切换键盘上面的listview
            switch(buttonType){
            case HWEmotionTabBarButtonType.HWEmotionTabBarButtonTypeRecent:
                // 最近
                self.addSubview(self.recentListView)
                break
            case HWEmotionTabBarButtonType.HWEmotionTabBarButtonTypeDefault:
                // 默认
                self.addSubview(self.defaultListView)
                break
            case HWEmotionTabBarButtonType.HWEmotionTabBarButtonTypeEmoji:
                // Emoji
                self.addSubview(self.emojiListView)
                break
            case HWEmotionTabBarButtonType.HWEmotionTabBarButtonTypeLxh:
                // Lxh
                self.addSubview(self.lxhListView)
                break
            }
            
            // 设置正在显示的listView
            self.showingListView=self.subviews.last as? HWEmotionListView
            
            // 设置frame
            self.setNeedsLayout()
    }
}