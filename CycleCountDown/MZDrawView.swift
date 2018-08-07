//
//  MZDrawView.swift
//  CycleCountDown
//
//  Created by Michael_Zuo on 2018/8/6.
//  Copyright © 2018年 Michael_Zuo. All rights reserved.
//

import UIKit

class MZDrawView: UIView {
    // MARK: property
    var lineWidth: CGFloat = 5.0
    var displayLink: CADisplayLink?
    var backPathColor: UIColor = UIColor.clear
    var cycleColor: UIColor?
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
    var progress: Double = 1.0 {
        didSet {
            if progress < 0 || progress > 1 {
                return
            }
            self.setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // public func
    open func drawCycleCountDown(center: CGPoint = CGPoint.zero, rad: CGFloat = 0.0) {
        self.setNeedsDisplay()
    }

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

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let radius = (min(rect.size.width, rect.size.height) - lineWidth) * 0.5
        let center = CGPoint(x: rect.size.width * 0.5, y: rect.size.height * 0.5)
        let backPath = UIBezierPath()
        backPath.lineWidth = lineWidth
        backPathColor.set()
        backPath.lineCapStyle = .round
        backPath.lineJoinStyle = .round
        backPath.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        backPath.stroke()


        let path = UIBezierPath()
        path.lineWidth = lineWidth
        cycleColor?.set()
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        let startAngle = CGFloat( Double.pi * (-0.5) + Double.pi * 2 * self.progress)
        let endAngle = CGFloat(Double.pi * (-0.5))
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.stroke()

    }


}
