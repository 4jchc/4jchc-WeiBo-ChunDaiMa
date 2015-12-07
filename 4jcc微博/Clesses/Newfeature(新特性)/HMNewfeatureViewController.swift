//
//  HMNewfeatureViewController.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/5.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HMNewfeatureViewController: UIViewController ,UIScrollViewDelegate{
    
    let HWNewfeatureCount = 4
    
    var scrollView:UIScrollView = UIScrollView()
    var pageControl:UIPageControl = UIPageControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// 1.创建一个scrollView：显示所有的新特性图片
        let scrollView:UIScrollView = UIScrollView()
        scrollView.frame = self.view.bounds
        self.view.addSubview(scrollView)
        self.scrollView = scrollView;
        
        /// 2.添加图片到scrollView中
        let scrollW:CGFloat = scrollView.frame.size.width
        let scrollH:CGFloat = scrollView.frame.size.height
        var i = 0
        for i; i<HWNewfeatureCount; i++ {
            let imageView:UIImageView = UIImageView()
            
            imageView.frame.size.width = scrollW;
            imageView.frame.size.height = scrollH;
            imageView.frame.origin.y = 0;
            imageView.frame.origin.x = CGFloat(i) * scrollW;
            // 显示图片
            let name:NSString = "new_feature_\(i + 1)"
            
            imageView.image = UIImage(named: name as String)
            scrollView.addSubview(imageView)
            
            // 如果是最后一个imageView，就往里面添加其他内容
            
            if (i == HWNewfeatureCount - 1) {
                
                setupLastImageView(imageView)
            }
        }
        
        ///*****✅#warning 默认情况下，scrollView一创建出来，它里面可能就存在一些子控件了
        ///*****✅#warning 就算不主动添加子控件到scrollView中，scrollView内部还是可能会有一些子控件
        
        // 3.设置scrollView的其他属性
        // 如果想要某个方向上不能滚动，那么这个方向对应的尺寸数值传0即可
        
        scrollView.contentSize = CGSizeMake(CGFloat(HWNewfeatureCount) * scrollW, 0);
        scrollView.bounces = false // 去除弹簧效果
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self;
        
        // 4.添加pageControl：分页，展示目前看的是第几页
        let pageControl:UIPageControl = UIPageControl()
        
        pageControl.numberOfPages = HWNewfeatureCount
        pageControl.backgroundColor = UIColor.redColor()
        pageControl.pageIndicatorTintColor = UIColor.RGB(189, 189, 189, 1.0)
        pageControl.currentPageIndicatorTintColor = UIColor.orangeColor()
     
        pageControl.center.x = scrollW * 0.5;
        pageControl.center.y = scrollH * 0.83;
        self.view.addSubview(pageControl)

        self.pageControl = pageControl
        
        // UIPageControl就算没有设置尺寸，里面的内容还是照常显示的
        //    pageControl.width = 100;
        //    pageControl.height = 50;
        //    pageControl.userInteractionEnabled = NO;
        
        //    UITextField *text = [[UITextField alloc] init];
        //    text.frame = CGRectMake(10, 20, 100, 50);
        //    text.borderStyle = UITextBorderStyleRoundedRect;
        //    [self.view addSubview:text];
 
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let page:Double = Double(scrollView.contentOffset.x) / Double(scrollView.frame.size.width)
        
        // 四舍五入计算出页码 Int(page + 0.5)
        
        self.pageControl.currentPage = Int(page + 0.5);
        // 1.3四舍五入 1.3 + 0.5 = 1.8 强转为整数(int)1.8= 1
        // 1.5四舍五入 1.5 + 0.5 = 2.0 强转为整数(int)2.0= 2
        // 1.6四舍五入 1.6 + 0.5 = 2.1 强转为整数(int)2.1= 2
        // 0.7四舍五入 0.7 + 0.5 = 1.2 强转为整数(int)1.2= 1
    }

    
    /**
    *  初始化最后一个imageView
    *
    *  @param imageView 最后一个imageView
    */
    func setupLastImageView(imageView:UIImageView){
        
    // 开启交互功能
    imageView.userInteractionEnabled = true
    
    // 1.分享给大家（checkbox）
        let shareBtn:UIButton = UIButton()
        shareBtn.setImage(UIImage(named: "new_feature_share_false"), forState: UIControlState.Normal)
        
        shareBtn.setImage(UIImage(named: "new_feature_share_true"), forState: UIControlState.Selected)
        
        
        shareBtn.setTitle("分享给大家", forState: UIControlState.Normal)
    
        shareBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)

    shareBtn.titleLabel!.font = UIFont.systemFontOfSize(15.0)
    shareBtn.frame.size.width = 200;
    shareBtn.frame.size.height = 30;
        
    shareBtn.center.x = imageView.frame.size.width * 0.5;
    shareBtn.center.y = imageView.frame.size.height * 0.65;
    shareBtn.addTarget(self, action: "shareClick:", forControlEvents: UIControlEvents.TouchUpInside)
    imageView.addSubview(shareBtn)
   
    //    shareBtn.backgroundColor = [UIColor redColor];
    //    shareBtn.imageView.backgroundColor = [UIColor blueColor];
    //    shareBtn.titleLabel.backgroundColor = [UIColor yellowColor];
    
    // top left bottom right
    
    // EdgeInsets: 自切
    // contentEdgeInsets:会影响按钮内部的所有内容（里面的imageView和titleLabel）
    //    shareBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 100, 0, 0);
    
    // titleEdgeInsets:只影响按钮内部的titleLabel
        
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    // imageEdgeInsets:只影响按钮内部的imageView
    //    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 50);
    
    
    
    //    shareBtn.titleEdgeInsets
    //    shareBtn.imageEdgeInsets
    //    shareBtn.contentEdgeInsets
    

    
    ////*****✅/ 2.开始微博
        let startBtn:UIButton = UIButton()

        startBtn.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal)
        
        startBtn.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
    
        startBtn.frame.size = startBtn.currentBackgroundImage!.size
        
        startBtn.center.x = shareBtn.center.x
        startBtn.center.y = imageView.frame.size.height * 0.75;
        startBtn.setTitle("开始微博", forState: UIControlState.Normal)
        startBtn.addTarget(self, action: "startClick", forControlEvents: UIControlEvents.TouchUpInside)
        imageView.addSubview(startBtn)
        
        
    }
    

    
    func shareClick(shareBtn:UIButton){
        
        // 状态取反
        shareBtn.selected = !shareBtn.selected
        
    }
    
    
    
    
    
    
    func startClick(){
    // 切换到HWTabBarController
    /*
    切换控制器的手段
    1.push：依赖于UINavigationController，控制器的切换是可逆的，比如A切换到B，B又可以回到A
    2.modal：控制器的切换是可逆的，比如A切换到B，B又可以回到A
    3.切换window的rootViewController
    */
        let window:UIWindow = UIApplication.sharedApplication().keyWindow!
   
        window.rootViewController = HWTabBarViewController()
    
    /// modal方式，不建议采取：新特性控制器不会销毁
//        let main:HWTabBarViewController = HWTabBarViewController()
//        self.presentViewController(main, animated: true, completion: nil)
    }


    deinit{
        print("\(self.classForCoder)")
        print("*****-dealloc")
        WBLog.Log("\(self.classForCoder)")
        
    }
    
    
    /*
    1.程序启动会自动加载叫做Default的图片
    1> 3.5inch 非retain屏幕：Default.png
    2> 3.5inch retina屏幕：Default@2x.png
    3> 4.0inch retain屏幕: Default-568h@2x.png
    
    2.只有程序启动时自动去加载的图片, 才会自动在4inch retina时查找-568h@2x.png
    */
    
    /*
    一个控件用肉眼看不见，有哪些可能
    1.根本没有创建实例化这个控件
    2.没有设置尺寸
    3.控件的颜色跟父控件的背景色一样（实际上已经显示了，只不过用肉眼看不见）
    4.透明度alpha <= 0.01
    5.hidden = YES
    6.没有添加到父控件中
    7.被其他控件挡住了
    8.位置不对
    9.父控件发生了以上情况
    10.特殊情况
    * UIImageView没有设置image属性，或者设置的图片名不对
    * UILabel没有设置文字，或者文字颜色和跟父控件的背景色一样
    * UITextField没有设置文字，或者没有设置边框样式borderStyle
    * UIPageControl没有设置总页数，不会显示小圆点
    * UIButton内部imageView和titleLabel的frame被篡改了，或者imageView和titleLabel没有内容
    * .....
    
    添加一个控件的建议（调试技巧）：
    1.最好设置背景色和尺寸
    2.控件的颜色尽量不要跟父控件的背景色一样
    */
    


}
