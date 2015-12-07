//
//  HWStatusPhotoView.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/11/30.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWStatusPhotoView: UIImageView {

    /**
     UIViewContentModeScaleToFill : 图片拉伸至填充整个UIImageView（图片可能会变形）
     
     UIViewContentModeScaleAspectFit : 图片拉伸至完全显示在UIImageView里面为止（图片不会变形）
     
     UIViewContentModeScaleAspectFill :
     图片拉伸至 图片的宽度等于UIImageView的宽度 或者 图片的高度等于UIImageView的高度 为止
     
     UIViewContentModeRedraw : 调用了setNeedsDisplay方法时，就会将图片重新渲染
     
     UIViewContentModeCenter : 居中显示
     UIViewContentModeTop,
     UIViewContentModeBottom,
     UIViewContentModeLeft,
     UIViewContentModeRight,
     UIViewContentModeTopLeft,
     UIViewContentModeTopRight,
     UIViewContentModeBottomLeft,
     UIViewContentModeBottomRight,
     
     经验规律：
     1.凡是带有Scale单词的，图片都会拉伸
     2.凡是带有Aspect单词的，图片都会保持原来的宽高比，图片不会变形
     */

    lazy var gifView:UIImageView? = {
        
        let ani = UIImage(named: "timeline_image_gif")
        let gifview1:UIImageView = UIImageView(image: ani)
        self.addSubview(gifview1)
        return gifview1
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        // 内容模式
        self.contentMode = UIViewContentMode.ScaleAspectFill;
        // 超出边框的内容都剪掉
        self.clipsToBounds = true

    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    var photo:HWPhoto?{
        
        didSet{
            
            // 设置图片
            self.sd_setImageWithURL(NSURL(string: photo!.thumbnail_pic as! String), placeholderImage: UIImage(named:"timeline_image_placeholder"))
            

            // 显示\隐藏gif控件
            // 判断是够以gif或者GIF结尾(lowercaseString小写)
            self.gifView!.hidden = !(photo?.thumbnail_pic?.lowercaseString.hasSuffix("gif"))!
   
        }
        
    }
    
//    private var _photo:HWPhoto!
//    var photo:HWPhoto!{
//        get{
//            return self._photo
//        }
//        set{
//            self._photo=newValue
//            // 设置图片
//            self.sd_setImageWithURL(NSURL(string: photo.thumbnail_pic as! String), placeholderImage: UIImage(named: "timeline_image_placeholder"))
//            // 显示\隐藏gif控件
//            // 判断是否以gif或者GIF结尾
//            self.gifView!.hidden = photo.thumbnail_pic!.lowercaseString.hasSuffix("gif")
//        }
//    }
    
    
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gifView!.frame.origin.x = self.frame.size.width - self.gifView!.frame.size.width;
        self.gifView!.frame.origin.y = self.frame.size.height - self.gifView!.frame.size.height;
    }
    
    



}
