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
        // default 默认为圆的顶点
//        drawView = MZDrawView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        // 自定义圆的起始点
        drawView = MZDrawView(frame: CGRect(x: 100, y: 100, width: 100, height: 100), angle: CGFloat.pi * (0.75))

        drawView?.backPathColor = UIColor.red
        drawView?.cycleColor = UIColor.cyan
        drawView?.duration = 10
        drawView?.textColor = UIColor.red
        // 半径
//        drawView?.radius = 20
        self.view.addSubview(drawView!)
        // Do any additional setup after loading the view.
    }
}

