//
//  ThinPulsing.swift
//  Moosic
//
//  Created by Oliver Green on 28/10/2018.
//  Copyright © 2018 Oliver Green. All rights reserved.
//

import UIKit

class ThinPulsing: CALayer {

    //@IBOutlet weak var btnScan : UIButton?
    
    var pulseLayers = [CAShapeLayer]()
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        
        super.init()
        
        pulseEffect()
    }

    func pulseEffect() {
        
        for _ in 0...2 {
            
            let circularPath = UIBezierPath(arcCenter: .zero, radius: UIScreen.main.bounds.size.width / 2.0, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
            let pulseLayer = CAShapeLayer()
            
            pulseLayer.path = circularPath.cgPath
            pulseLayer.lineWidth = 1
            pulseLayer.fillColor = UIColor.clear.cgColor
            pulseLayer.strokeColor = UIColor.white.cgColor
            pulseLayer.lineCap = kCALineCapRound
            //pulseLayer.position = CGPoint(x: (btnScan?.frame.size.width)! / 2.0, y: (btnScan?.frame.size.width)! / 2.0)
            
            pulseLayer.position = CGPoint(x: 200, y: 200)
            
            //btnScan?.layer.addSublayer(pulseLayer)
            pulseLayers.append(pulseLayer)
        }
        
        animatePulse(index: 1)
        animatePulse(index: 2)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animatePulse(index: 0)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.animatePulse(index: 1)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.animatePulse(index: 2)
                }
            }
        }
    }

    func animatePulse(index: Int) {
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        
        scaleAnimation.duration = 2.0
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 0.9
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(scaleAnimation, forKey: "scale")
        
        opacityAnimation.duration = 2.0
        opacityAnimation.fromValue = 0.9
        opacityAnimation.toValue = 0.0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayers[index].add(opacityAnimation, forKey: "opacity")
    }
}
