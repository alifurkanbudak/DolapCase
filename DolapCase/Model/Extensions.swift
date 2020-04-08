//
//  Utility.swift
//  DolapCase
//
//  Created by Ali Furkan Budak on 7.04.2020.
//  Copyright © 2020 Ali Furkan Budak. All rights reserved.
//

import Foundation
import  UIKit

extension UIView {
    
    // Adds circular progress bar(counter) to a view
    func addCounter(percentage: Double, size: Int, thickness: Int) {
        
        // This is where the counter is placed befor this is added as a subview to the actual view
        let subView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        
        let circleLayer = CAShapeLayer() // Background layer of the counter
        let progressLayer = CAShapeLayer() // Actual progress bar layer
        
        let center = subView.center
        let circularPath = UIBezierPath(arcCenter: center, radius: CGFloat(size-thickness)/2, startAngle: -.pi/2, endAngle: (3/2) * .pi, clockwise: true)
        
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = CGFloat(thickness)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.systemYellow.cgColor
        progressLayer.lineCap = .butt
        progressLayer.lineWidth = CGFloat(thickness)
        progressLayer.strokeEnd = CGFloat(percentage) // Cuts the progress bar path according to percentage
        
        subView.layer.addSublayer(circleLayer)
        subView.layer.addSublayer(progressLayer)
        self.addSubview(subView)
    }
    
    // Reaches the last sublayer of the last subview's layer. If it's a CAShapeLayer it changes the percentage
    func updateCounterPercent(percentage: Double) {
        if let counter = self.subviews.last?.layer.sublayers?.last as? CAShapeLayer {
            counter.strokeEnd = CGFloat(percentage)
        }
    }
}
