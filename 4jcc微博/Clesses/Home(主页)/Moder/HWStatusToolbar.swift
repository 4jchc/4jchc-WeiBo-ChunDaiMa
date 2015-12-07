//
//  HWStatusToolbar.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/11/30.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWStatusToolbar: UIView {



    
    var repostBtn:UIButton?
    var commentBtn:UIButton?
    var attitudeBtn:UIButton?
    
    
    /** 里面存放所有的按钮 */
    lazy var btns:NSMutableArray? = {
        
        let ani = NSMutableArray()
        
        return ani
    }()
    /** 里面存放所有的分割线 */
    lazy var dividers:NSMutableArray? = {
        
        let ani = NSMutableArray()
        
        return ani
    }()

    
    func toolbar() ->HWStatusToolbar{
        
        return self
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(patternImage: UIImage(named: "timeline_card_bottom_background")!)
   
        // 添加按钮
        self.repostBtn = self.setupBtn("转发" ,icon:"timeline_icon_retweet")
        self.commentBtn = self.setupBtn("评论" ,icon:"timeline_icon_comment")
        self.attitudeBtn = self.setupBtn("赞" ,icon:"timeline_icon_unlike")
        
        // 添加分割线
        self.setupDivider()
        self.setupDivider()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    /**
    * 添加分割线
    */
    func setupDivider(){
        let divider: UIImageView = UIImageView()
        divider.image = UIImage(named: "timeline_card_bottom_line")
        self.addSubview(divider)
        
        self.dividers!.addObject(divider)
    }
    
    
    /**
     * 初始化一个按钮
     * @param title : 按钮文字
     * @param icon : 按钮图标
     */
    func setupBtn(title:NSString ,icon:NSString)->UIButton{
        let btn: UIButton = UIButton()
        btn.setImage(UIImage(named: icon as String), forState: UIControlState.Normal)
        
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        btn.setTitle(title as String, forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "timeline_card_bottom_background_highlighted"), forState: UIControlState.Highlighted)
     
        btn.titleLabel!.font = UIFont.systemFontOfSize(13)
        self.addSubview(btn)
        
        self.btns!.addObject(btn)

        return btn;
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置按钮的frame
        let btnCount:Int = self.btns!.count;
        let btnW: CGFloat = self.frame.size.width / CGFloat(btnCount)
        let btnH: CGFloat = self.frame.size.height;
        for (var i = 0; i<btnCount; i++) {
            let btn: UIButton  = self.btns![i] as! UIButton;
            btn.frame.origin.y = 0;
            btn.frame.size.width = btnW;
            btn.frame.origin.x = CGFloat(i) * btnW;
            btn.frame.size.height = btnH;
        }
        
        // 设置分割线的frame
         let dividerCount:Int = self.dividers!.count;
        for (var i = 0; i<dividerCount; i++) {
            let divider: UIImageView = self.dividers![i] as! UIImageView;
            divider.frame.size.width = 1;
            divider.frame.size.height = btnH;
            divider.frame.origin.x = CGFloat(i + 1) * btnW;
            divider.frame.origin.y = 0;
        }
    }
    
    
    var status:HWStatus?{
        
        didSet{
            
            //    status.reposts_count = 580456; // 58.7万
            //    status.comments_count = 100004; // 1万
            //    status.attitudes_count = 604; // 604
            
            // 转发
            self.setupBtnCount(status!.reposts_count! as Int, btn: self.repostBtn!, title: "转发")
     
            // 评论
            self.setupBtnCount(status!.comments_count! as Int, btn: self.commentBtn!, title: "评论")
      
            // 赞
            self.setupBtnCount(status!.attitudes_count! as Int, btn: self.attitudeBtn!, title: "赞")
            
        }
        
    }

    
    func setupBtnCount(count:Int,btn:UIButton,var title:NSString){
        if (count != 0) { // 数字不为0
            if (count < 10000) { // 不足10000：直接显示数字，比如786、7986
                title = "\(count)"
                
            } else { // 达到10000：显示xx.x万，不要有.0的情况
                let wan:Double = Double(count) / 10000.0;
                title = NSString(format: "%.1f万", wan)
                // 将字符串里面的.0去掉
                title = title.stringByReplacingOccurrencesOfString(".0", withString: "")

        }
            btn.setTitle(title as String, forState: UIControlState.Normal)
       
        }
    }
    

    
}
