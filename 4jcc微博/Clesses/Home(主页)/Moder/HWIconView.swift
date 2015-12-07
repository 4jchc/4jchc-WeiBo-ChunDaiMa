//
//  HWIconView.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/12/1.
//  Copyright © 2015年 sijichcai. All rights reserved.
//


import UIKit

class HWIconView: UIImageView {
    

//    private var _user:HWUser?
//    var user:HWUser?{
//        set{
//            self._user=newValue
//            
//            // 1.下载图片
//            self.sd_setImageWithURL(NSURL(string: newValue!.profile_image_url), placeholderImage: UIImage(named: "avatar_default_small"))
//            
//            // 2.设置加V图片
//            if let verifiedType=newValue!.verified_type{
//                switch(verifiedType){
//                case 0: // 个人认证
//                    self.verifiedView.hidden=false
//                    self.verifiedView.image=UIImage(named: "avatar_vip")
//                    break
//                case 2,3,5: // 官方认证
//                    self.verifiedView.hidden=false
//                    self.verifiedView.image=UIImage(named: "avatar_enterprise_vip")
//                    break
//                case 220: // 微博达人
//                    self.verifiedView.hidden=false
//                    self.verifiedView.image=UIImage(named: "avatar_grassroot")
//                    break
//                default:
//                    self.verifiedView.hidden=true // 当做没有任何认证
//                    break
//                }
//            }else{
//                self.verifiedView.hidden=true // 当做没有任何认证
//            }
//        }
//        get{
//            return self._user
//        }
//    }

    
    
    
    
    
    
    
    var user:HWUser?{
        
        didSet{
            
            // 1.下载图片
            self.sd_setImageWithURL(NSURL(string: user!.profile_image_url as String), placeholderImage: UIImage(named: "avatar_default_small"))
            
            // 2.设置加V图片
            if let verifiedType = user!.verified_type{
                switch verifiedType {
                case 0: // 个人认证
                    self.verifiedView!.hidden=false
                    self.verifiedView!.image=UIImage(named: "avatar_vip")

                case 2,3,5: // 官方认证
                    self.verifiedView!.hidden=false
                    self.verifiedView!.image=UIImage(named: "avatar_enterprise_vip")
      
                case 220: // 微博达人
                    self.verifiedView!.hidden=false
                    self.verifiedView!.image=UIImage(named: "avatar_grassroot")
             
                default:
                    self.verifiedView!.hidden=true // 当做没有任何认证
                    self.verifiedView!.image=UIImage(named: "avatar_grassroot")
                    break
                }
            }else{
                self.verifiedView!.hidden=true // 当做没有任何认证
            }

            
        }
        
    }
    

    
    
    
    
    lazy var verifiedView:UIImageView? = {
        
        var ani = UIImageView()
        self.addSubview(ani)
        return ani
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.verifiedView?.frame.size=self.verifiedView!.image!.size
        if let image=self.verifiedView!.image{
            self.verifiedView?.frame.size=image.size
        }else{
            self.verifiedView?.frame.size=CGSize.zero
        }
        let scale:CGFloat=0.6
        self.verifiedView?.frame.origin.x=self.frame.size.width-(self.verifiedView?.frame.size.width)!*scale
        self.verifiedView?.frame.origin.y=self.frame.size.height-(self.verifiedView?.frame.size.height)!*scale
    }
    
}
