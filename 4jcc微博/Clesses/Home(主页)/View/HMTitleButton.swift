//
//  HMTitleButton.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/11/7.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HMTitleButton: UIButton {
    
    let HMMargin:CGFloat = 10
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        //frame.size.width += HMMargin
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.titleLabel!.font = UIFont.boldSystemFontOfSize(17.0)
        //self.backgroundColor = UIColor.redColor()
        self.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        self.setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        
        ///*****✅先把image调出来.不然一开始标题会偏移
        self.imageView?.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///*****✅如果仅仅是调整按钮内部titleLabel和imageView的位置，那么在layoutSubviews中单独设置位置即可
    override func layoutSubviews() {
        
        super.layoutSubviews()
        // 如果仅仅是调整按钮内部titleLabel和imageView的位置，那么在layoutSubviews中单独设置位置即可
        
        /// 1.计算titleLabel的frame
        self.titleLabel!.frame.origin.x = (self.imageView!.frame.origin.x)
        /// 2.计算imageView的frame
        self.imageView!.frame.origin.x = CGRectGetMaxX(self.titleLabel!.frame) + 3
        
    }
    
    
    
    ///*****✅重写set方法--就直接计算自己的尺寸
    
    override func setImage(image: UIImage?, forState state: UIControlState) {
        super.setImage(image, forState: state)
        
        // 只要修改了图片，就让按钮重新计算自己的尺寸
        self.sizeToFit()
    }
    
    
    ///*****✅重写set方法--就直接计算自己的尺寸
    override func setTitle(title: String?, forState state: UIControlState) {
        
        super.setTitle(title, forState: state)
        
        // 只要修改了文字，就让按钮重新计算自己的尺寸
        self.sizeToFit()
    }
    // 目的：想在系统计算和设置完按钮的尺寸后，再修改一下尺寸
    /**
    *  重写setFrame:方法的目的：拦截设置按钮尺寸的过程
    *  如果想在系统设置完控件的尺寸后，再做修改，而且要保证修改成功，一般都是在setFrame:中设置
    */
    override var frame:CGRect{
        set{
            var f = newValue
            f.size.width += HMMargin
            super.frame=f
        }
        get{
            return super.frame
        }
    }

    
    ///*****✅设置按钮内部title的frame
    //    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
    //
    //    }
    ///*****✅设置按钮内部image的frame
    //    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
    //        
    //    }
    
    
    
    
}


