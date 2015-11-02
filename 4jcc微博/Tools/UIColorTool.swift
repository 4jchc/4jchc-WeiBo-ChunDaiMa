

import UIKit



///*****✅随机颜色color
class UIColorTool: UIColor {

  ///*****✅随机颜色color
  class func randomColor() -> UIColor{
    /*
    颜色有两种表现形式 RGB RGBA
    RGB 24
    R,G,B每个颜色通道8位
    8的二进制 255
    R,G,B每个颜色取值 0 ~255
    120 / 255.0
    */
    let r:CGFloat = CGFloat(arc4random_uniform(UInt32(256))) / 255.0
    let g:CGFloat = CGFloat(arc4random_uniform(UInt32(256))) / 255.0
    let b:CGFloat = CGFloat(arc4random_uniform(UInt32(256))) / 255.0
    
    return UIColor(red: r, green: g, blue: b, alpha: 1)

    }
}
