//
//  HWEmotionListView.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWEmotionListView: UIView,UIScrollViewDelegate {


    
    var scrollView:UIScrollView!
    var pageControl:UIPageControl!
//    /** 表情(里面存放的HWEmotion模型) */
    private var _emotions:NSArray?
    /** 根据emotions，创建对应个数的表情 */
    var emotions:NSArray!{
        get{
            return self._emotions == nil ? NSArray():self._emotions!
        }
        set{
            self._emotions=newValue
            ///*****✅let 页数 = (总数 + 每页数 - !) / 每页数
            let count=(emotions.count + Int(HWEmotionPageSize) - 1)/Int(HWEmotionPageSize)
            // 1.设置页数
            self.pageControl.numberOfPages=count
            if(count == 0){
                return
            }
    
            
            // 删除之前的控件
            self.scrollView.subviews.forEach { (view:UIView) -> () in
                view.removeFromSuperview()
            }
            // 2.创建用来显示每一项表情的控件
            for i:Int in 0...count-1{
                let pageView=HWEmotionPageView()
                // 计算这一页的表情范围
                var range=NSRange()
                range.location = i * Int(HWEmotionPageSize)
                // left：剩余的表情个数（可以截取的）
                let left=emotions.count-range.location
                if(left >= Int(HWEmotionPageSize)){
                    // 这一页足够20个
                    range.length = Int(HWEmotionPageSize)
                }else{
                    range.length=left
                }
                // 设置这一页的表情
                pageView.emotions = emotions.subarrayWithRange(range)
                self.scrollView.addSubview(pageView)
            }
            
            self.setNeedsLayout()
        }
    }
    
    
    
    
    
    
//    /** 根据emotions，创建对应个数的表情 */
//    var emotions:NSArray!{
//        
//        didSet{
//            
//            
//            let count=(emotions.count + Int(HWEmotionPageSize) - 1)/Int(HWEmotionPageSize)
//            // 1.设置页数
//            self.pageControl.numberOfPages=count
//            if(count == 0){
//                return
//            }
//            
//            // 删除之前的控件
//            self.scrollView.subviews.forEach { (view:UIView) -> () in
//                view.removeFromSuperview()
//            }
//            // 2.创建用来显示每一项表情的控件
//            for i:Int in 0...count-1{
//                let pageView=HWEmotionPageView()
//                // 计算这一页的表情范围
//                var range=NSRange()
//                range.location = i * Int(HWEmotionPageSize)
//                // left：剩余的表情个数（可以截取的）
//                let left=emotions.count-range.location
//                if(left >= Int(HWEmotionPageSize)){
//                    // 这一页足够20个
//                    range.length = Int(HWEmotionPageSize)
//                }else{
//                    range.length=left
//                }
//                // 设置这一页的表情
//                pageView.emotions = emotions.subarrayWithRange(range)
//                self.scrollView.addSubview(pageView)
//            }
//            
//            self.setNeedsLayout()
//        }
//        
//    }
    

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor=UIColor.whiteColor()
        // 1.UIScrollView
        let sv=UIScrollView()
        sv.pagingEnabled=true
        sv.delegate=self
        // 去除水平方向的滚动条
        sv.showsHorizontalScrollIndicator=false
        // 去除垂直方向的滚动条
        sv.showsVerticalScrollIndicator=false
        self.addSubview(sv)
        self.scrollView=sv
        
        // 2.pageControl
        let pc=UIPageControl()
        // 当只有1页时，自动隐藏pageControl
        pc.hidesForSinglePage=true
        pc.userInteractionEnabled=false
        // 设置内部的圆点图片 //MARK: KVC赋值-UIPageControl
        pc.setValue(UIImage(named: "compose_keyboard_dot_normal"), forKeyPath: "pageImage")
        pc.setValue(UIImage(named: "compose_keyboard_dot_selected"), forKeyPath: "currentPageImage")
//        pc.currentPageIndicatorTintColor = UIColor.RGB(247, 108, 10, 1)
//        pc.pageIndicatorTintColor = UIColor.RGB(197, 197, 197, 1)
        self.addSubview(pc)
        self.pageControl=pc
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 1.pageControl
        self.pageControl.frame.size.width = self.frame.size.width
        self.pageControl.frame.size.height = 25
        self.pageControl.frame.origin.x = 0
        self.pageControl.frame.origin.y = self.frame.size.height - self.pageControl.frame.size.height
        
        // 2.scrollView
        self.scrollView.frame.size.width=self.frame.size.width
        self.scrollView.frame.size.height=self.pageControl.frame.origin.y
        self.scrollView.frame.origin.x = 0
        self.scrollView.frame.origin.y = 0
        
       //MARK: 3.设置scrollView内部每一页的尺寸
        let count=self.scrollView.subviews.count
        if(count == 0){
            return
        }
        for i:Int in 0...count-1{
            let pageView=self.scrollView.subviews[i] as! HWEmotionPageView
            pageView.frame.size.height=self.scrollView.frame.size.height
            pageView.frame.size.width=self.scrollView.frame.size.width
            pageView.frame.origin.x = pageView.frame.size.width * CGFloat(i)
            pageView.frame.origin.y=0
        }
        //4.设置scrollView的contentSize
        self.scrollView.contentSize=CGSizeMake(CGFloat(count)*self.scrollView.frame.size.width, 0)
    }
    
    // MARK: scrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageNo:CGFloat=scrollView.contentOffset.x / scrollView.frame.size.width
        self.pageControl.currentPage=Int(pageNo + 0.5)
    }

}
