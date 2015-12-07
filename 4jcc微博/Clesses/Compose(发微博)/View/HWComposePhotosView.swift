//
//  HWComposePhotosView.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/3.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWComposePhotosView: UIView {

    // 默认会自动生成setter和getter的声明和实现、_开头的成员变量
    // 如果手动实现了setter和getter，那么就不会再生成settter、getter的实现、_开头的成员变量
    
    //@property (nonatomic, strong, readonly) NSMutableArray *addedPhotos;
    // 默认会自动生成getter的声明和实现、_开头的成员变量
    // 如果手动实现了getter，那么就不会再生成getter的实现、_开头的成员变量

    lazy var photos:[UIImage]=[UIImage]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addPhoto(photo:UIImage){
        let photoView=UIImageView()
        photoView.image=photo
        self.addSubview(photoView)
        
        // 存储图片
        self.photos.append(photo)
    }
    
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置图片的尺寸和位置
        let count=self.subviews.count
        let maxCol:Int=4
        let imageWH:CGFloat=70
        let imageMargin:CGFloat=10
        if(count==0){
            return
        }
        for i:Int in 0...count-1{
            let photoView=self.subviews[i] as! UIImageView
            let col = CGFloat(i % maxCol)
            photoView.x=col*(imageWH+imageMargin)
            
            let row=CGFloat(i/maxCol)
            photoView.y=row*(imageWH + imageMargin)
            photoView.width=imageWH
            photoView.height=imageWH
        }
    }
    

}
