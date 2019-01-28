//
//  Pulsing.swift
//  Moosic
//
//  Created by Oliver Green on 28/10/2018.
//  Copyright © 2018 Oliver Green. All rights reserved.
//

import UIKit

class Pulsing: CAGradientLayer {
    
    var animationGroup = CAAnimationGroup()
    
    var initialPulseScale : Float = 0.0
    var nextPulseAfter : TimeInterval = 0
    var animationDuration : TimeInterval = 4
    var radius : CGFloat = 200
    var numberOfPulses : Float = Float.infinity
    
    let myOrange = UIColor(red: 255/255.0, green: 81/255.0, blue: 45/255.0, alpha: 1).cgColor
    let myPink = UIColor(red: 255/255.0, green: 29/255.0, blue: 119/255.0, alpha: 1).cgColor
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (numberOfPulses : Float = Float.infinity, radius : CGFloat, position : CGPoint) {
        
        super.init()
        
        //self.backgroundColor = UIColor.black.cgColor
        self.colors = [myOrange, myPink]
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = radius
        self.numberOfPulses = numberOfPulses
        self.position = position
        
        self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        self.cornerRadius = radius
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.setupAnimationGroup()
            
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
    }
    
    func scaleAnimation() -> CABasicAnimation {
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        
        scaleAnimation.fromValue = NSNumber(value: initialPulseScale)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = animationDuration
        
        return scaleAnimation
    }
    
    func opacityAnimation() -> CAKeyframeAnimation {
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [0.4, 0.8, 0]
        opacityAnimation.keyTimes = [0, 0.2, 1]
        
        return opacityAnimation
    }
    
    func setupAnimationGroup() {
    
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = animationDuration + nextPulseAfter
        self.animationGroup.repeatCount = numberOfPulses
        
        let defaultCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        self.animationGroup.timingFunction = defaultCurve
        
        self.animationGroup.animations = [scaleAnimation(), opacityAnimation()]
    }
}
