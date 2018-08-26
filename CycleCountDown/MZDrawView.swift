//
//  MZDrawView.swift
//  CycleCountDown
//
//  Created by Michael_Zuo on 2018/8/6.
//  Copyright © 2018年 Michael_Zuo. All rights reserved.
//

import UIKit

fileprivate let  Margin: CGFloat = 5.0
class MZDrawView: UIView {

    // MARK: property
    /// 圆圈的宽度
    var lineWidth: CGFloat = 5.0
    private var displayLink: CADisplayLink?
    var backPathColor: UIColor = UIColor.clear
    /// 圆圈颜色
    var cycleColor: UIColor?
    // 默认起始和结束都在圆的顶点
    var angle: CGFloat = CGFloat.pi * (-0.5)
    /// 倒计时时间label的文字颜色
    var textColor: UIColor? {
        didSet {
           self.timerLabel.textColor = textColor ?? UIColor.white
        }
    }
    /// 中间显示的倒计时时间
    var timerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    /// 自定义半径
    var radius: CGFloat = 0.0
    /// 自定义圆的中心点
    var cycleCenter: CGPoint = CGPoint.zero
    
    // 倒计时时间
    var duration: Double = 0.0 {
        didSet {
            if duration < 0.0 { return }
            // 先停掉link
            invalidateLink()
            // 在开启link
            self.displayLink = CADisplayLink(target: self, selector: #selector(countDown))
            self.displayLink?.add(to: RunLoop.current, forMode: .commonModes)
            
        }
    }
    // 当前进度
    var progress: Double = 1.0 {
        didSet {
            if progress < 0 || progress > 1 {
                return
            }
            // ceil(返回不小于x的最小整数值)
            self.timerLabel.text = "\(ceil(self.progress * duration))"
            self.setNeedsDisplay()
        }
    }
    
    // public func
    
    /// 更新进度，可以触发添加进度条
    ///
    open func update(_ time: Double) {
        let orginalDuration = self.duration
        let orginalProgress = self.progress
        self.duration = orginalDuration + time
        let newProgress = 1 -  (orginalProgress * orginalDuration) / (orginalDuration + time)
        self.progress = newProgress
        
        
        
    }
    
    /// 在不用的时候要call一下 停掉link
    // 比如 vc的deinit方法里
    open func invalidateLink() {
        guard let displayLink = self.displayLink else {
            return
        }
        displayLink.isPaused = true
        displayLink.invalidate()
    }
    
    
    // private func
    
    /// 倒计时 1/60s调用一次
    @objc private func countDown() {
        if progress < 0.0 || progress > 1.0 {
            invalidateLink()
            self.progress = 0.0
            return
        }
        self.progress -= Double((1/60) / self.duration)
    }
    
    override func draw(_ rect: CGRect) {
        // 没有自定义半径和中心的话取默认
        let radius = self.radius == 0.0 ? (min(rect.size.width, rect.size.height) - lineWidth) * 0.5 : self.radius
        let center = self.cycleCenter == CGPoint.zero ? CGPoint(x: rect.size.width * 0.5, y: rect.size.height * 0.5) : self.cycleCenter
        
        let backPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        backPath.lineWidth = lineWidth
        backPath.lineCapStyle = .round
        backPath.lineJoinStyle = .round
        backPathColor.set()
        backPath.stroke()

        
        let endAngle = self.angle + CGFloat.pi * 2 * CGFloat(self.progress)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: self.angle, endAngle: endAngle, clockwise: true)
        cycleColor?.set()
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.stroke()

    }
    // MARK: init func
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.timerLabel)
        let width = self.frame.size.width - lineWidth * 2 - Margin * 2
        let height = self.frame.size.height - lineWidth * 2 - Margin * 2
        self.timerLabel.frame = CGRect(x: (self.frame.size.height - height)  * 0.5, y: (self.frame.size.width - width)  * 0.5, width: width, height: height)
        self.timerLabel.textColor = textColor ?? UIColor.white
        
    }
    convenience init(frame: CGRect ,angle:CGFloat) {
        self.init(frame: frame)
        self.angle = angle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

