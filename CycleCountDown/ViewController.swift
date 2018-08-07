//
//  ViewController.swift
//  CycleCountDown
//
//  Created by Michael_Zuo on 2018/8/6.
//  Copyright © 2018年 Michael_Zuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    deinit {
        // 页面销毁的时候记得 call invalidateLink func
        self.drawView?.invalidateLink()
    }
    var drawView: MZDrawView?
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView = MZDrawView(frame: CGRect(x: 100, y: 100, width: 100, height: 200))
        drawView?.backPathColor = UIColor.red
        drawView?.cycleColor = UIColor.cyan
        drawView?.duration = 10
        // 半径
        drawView?.radius = 20
        self.view.addSubview(drawView!)
        // Do any additional setup after loading the view.
    }
}

