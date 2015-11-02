//
//  HWTest1ViewController.swift
//  4jcc微博
//
//  Created by 蒋进 on 15/11/2.
//  Copyright © 2015年 sijichcai. All rights reserved.
//

import UIKit

class HWTest1ViewController: UIViewController {

    
    init(){
        super.init(nibName: "HWTest1ViewController", bundle: nil)
    }
    
    
   
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let tex2:HWTest2ViewController = HWTest2ViewController()
        tex2.title = "测试2控制器";
        self.navigationController?.pushViewController(tex2, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
