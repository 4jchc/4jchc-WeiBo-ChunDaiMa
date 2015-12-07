//
//  HWStatusPhotosView.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/11/30.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

let HWStatusPhotoWH = 70
let HWStatusPhotoMargin = 10

class HWStatusPhotosView: UIView {
    

    
   static func HWStatusPhotoMaxCol(count:Int) ->Int{
        
        return count == 4 ? 2 : 3
    }
    
    
    

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    var photos:NSArray?{
        
        didSet{

            let photosCount:Int = photos!.count;
            
            
            // 创建足够数量的图片控件
            // 这里的self.subviews.count不要单独赋值给其他变量
            while (self.subviews.count < photosCount) {
                let photoView:HWStatusPhotoView = HWStatusPhotoView(frame: CGRect.null)
                self.addSubview(photoView)
            }
            
            // 遍历所有的图片控件，设置图片
            for (var i = 0; i<self.subviews.count; i++) {
                
                let photoView:HWStatusPhotoView = self.subviews[i] as! HWStatusPhotoView

                if (i < photosCount) { // 显示
                    photoView.photo = photos![i] as? HWPhoto;
                    photoView.hidden = false
                } else { // 隐藏
                    photoView.hidden = true
                }
            }
            
        }
        
    }

    
    
    
    
    
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置图片的尺寸和位置
        let photosCount:Int = self.photos!.count;
        let maxCol:Int = HWStatusPhotosView.HWStatusPhotoMaxCol(photosCount)
        for (var i = 0; i<photosCount; i++) {
                        let photoView:HWStatusPhotoView = self.subviews[i] as! HWStatusPhotoView
            let col:Int = i % maxCol;
            photoView.frame.origin.x = CGFloat(col * (HWStatusPhotoWH + HWStatusPhotoMargin))
            
             let row:Int = i / maxCol;
            photoView.frame.origin.y = CGFloat(row * (HWStatusPhotoWH + HWStatusPhotoMargin))
            photoView.frame.size.width = CGFloat(HWStatusPhotoWH)
            photoView.frame.size.height = CGFloat(HWStatusPhotoWH)
        }
    }
    
    
    

    

    //MARK: - 根据图片个数计算相册的尺寸
   class func sizeWithCount(count:Int)->CGSize{
        // 最大列数（一行最多有多少列）
         let maxCols:Int = self.HWStatusPhotoMaxCol(count);
        
       // 列数
         let cols:Int = (count >= maxCols) ? maxCols : count;
        let photosW: CGFloat = CGFloat(cols * HWStatusPhotoWH + (cols - 1) * HWStatusPhotoMargin)
        
        // 行数
         let rows:Int = (count + maxCols - 1) / maxCols;
         let photosH: CGFloat = CGFloat(rows * HWStatusPhotoWH + (rows - 1) * HWStatusPhotoMargin)
        
        return CGSizeMake(photosW, photosH)
    }

}
