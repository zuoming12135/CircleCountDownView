//
//  ViewController.swift
//  CycleCountDown
//
//  Created by Michael_Zuo on 2018/8/6.
//  Copyright © 2018年 Michael_Zuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let drawView = MZDrawView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        drawView.backPathColor = UIColor.red
        drawView.cycleColor = UIColor.cyan
        drawView.duration = 10
        self.view.addSubview(drawView)
    }
    



}

