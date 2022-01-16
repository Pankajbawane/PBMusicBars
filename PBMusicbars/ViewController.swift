//
//  ViewController.swift
//  PBMusicbars
//
//  Created by Mac on 16/01/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Music Bars"
        
        for i in 0...5 {
            addMusicBars(offset: CGFloat(i) * 30.0)
        }
    }
    
    private func addMusicBars(offset: CGFloat) {
        
        // Size of a bar.
        let barSize: CGSize = CGSize(width: 25.0, height: 100.0)
        
        // Layer for Bar.
        let barLayer = CAShapeLayer()
        barLayer.frame = CGRect(x: 120.0 + offset, y: 400.0, width: barSize.width, height: barSize.height)
        barLayer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        barLayer.masksToBounds = true
        
        // Gradient Layer for Bar.
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.yellow.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: barSize.width, height: barSize.height + 10.0)
        
        barLayer.addSublayer(gradientLayer)
        
        // Duration for Bar animation.
        let totalDuration: Double = 3 + Double.random(in: -1.0...1.5)
        let animDur1: Double = totalDuration * (2.0 / 7.0)
        let animDur2: Double = totalDuration * (1.0 / 7.0)
        let animDur3: Double = totalDuration * (4.0 / 7.0)
        
        // Begin Time for mid and final animations.
        let animBeginTime2: Double = animDur1
        let animBeginTime3: Double = animDur1 + animDur2
        
        // Animate Bar size from 0% to 60%.
        let initialAnimation = CABasicAnimation(keyPath: "bounds.size.height")
        initialAnimation.fromValue = 0.0
        initialAnimation.toValue = Double(barSize.height * 0.6)
        initialAnimation.duration = animDur1
        initialAnimation.beginTime = 0.0
        initialAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        // Animate Bar size from 60% to 100%.
        let midAnimation = CABasicAnimation(keyPath: "bounds.size.height")
        midAnimation.fromValue = initialAnimation.toValue
        midAnimation.toValue = Double(barSize.height)
        midAnimation.duration = animDur2
        midAnimation.beginTime = animBeginTime2
        midAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        // Animate Bar size from 100% to 0%.
        let finalAnimation = CABasicAnimation(keyPath: "bounds.size.height")
        finalAnimation.fromValue = midAnimation.toValue
        finalAnimation.toValue = 0.0
        finalAnimation.duration = animDur3
        finalAnimation.beginTime = animBeginTime3
        finalAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        
        let group = CAAnimationGroup()
        group.duration = totalDuration
        group.repeatCount = .greatestFiniteMagnitude
        group.animations = [initialAnimation, midAnimation, finalAnimation]
        
        barLayer.add(group, forKey: nil)
        view.layer.addSublayer(barLayer)
        
        // Add a border layer.
        let shape = CAShapeLayer()
        shape.frame = CGRect(x: 0.0, y: 450.0, width: view.bounds.width, height: 2.0)
        shape.backgroundColor = UIColor.orange.cgColor
        
        view.layer.addSublayer(shape)
    }
}

