//
//  ViewController.swift
//  Extension
//
//  Created by 钟凡 on 2017/9/21.
//  Copyright © 2017年 钟凡. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = UIView()
        
        print(v.zf.viewName)
        print(1.zf.doubleValue)
        print("fan".zf.hello)
        print(v.zf.instance)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

