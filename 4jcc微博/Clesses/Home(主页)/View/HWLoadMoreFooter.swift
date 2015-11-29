//
//  HWLoadMoreFooter.swift
//  4j成才-微博
//
//  Created by 蒋进 on 15/11/7.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWLoadMoreFooter: UIView {


   class func footer()->UIView{
        
      return  NSBundle.mainBundle().loadNibNamed("HWLoadMoreFooter", owner: nil, options: nil).last as! UIView
        
}
}