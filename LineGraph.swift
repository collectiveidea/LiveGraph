//
//  LineGraph.swift
//  [i]Kegerator
//
//  Created by Ben Lambert on 9/11/15.
//  Copyright © 2015 Collective Idea. All rights reserved.
//

import UIKit

public class LineGraph: GraphView {
    
    override func createGraphSection() {
        for number in 0..<points.count {
            drawGraph(number)
            fillGraph(number)
            addDotsToGraph(number)
        }
    }
    
    public func drawGraph(number:Int) {
        let line = UIBezierPath()
        line.moveToPoint(points[number][0])
        for incrementer in 1..<points[number].count {
            line.addCurveToPoint(points[number][incrementer], controlPoint1: CGPointMake(points[number][incrementer - 1].x + xValuesDistanceApart / 2, points[number][incrementer - 1].y), controlPoint2: CGPointMake(points[number][incrementer].x - xValuesDistanceApart / 2, points[number][incrementer].y))
            print("YVals : \(points[number][incrementer].y)")
        }
        
        let lineShape = CAShapeLayer()
        lineShape.path = line.CGPath
        lineShape.lineWidth = 1
        lineShape.strokeColor = colors[number].CGColor
        lineShape.fillColor = UIColor.clearColor().CGColor
        self.scrollView.layer.addSublayer(lineShape)
    }
    
    public func fillGraph(number:Int) {
        let line = UIBezierPath()
        line.moveToPoint(CGPointMake(points[number][0].x, CGRectGetHeight(scrollView.frame) - bottomGutterSize))
        line.addLineToPoint(points[number][0])
        for incrementer in 1..<points[number].count {
            line.addCurveToPoint(points[number][incrementer], controlPoint1: CGPointMake(points[number][incrementer - 1].x + xValuesDistanceApart / 2, points[number][incrementer - 1].y), controlPoint2: CGPointMake(points[number][incrementer].x - xValuesDistanceApart / 2, points[number][incrementer].y))
        }
        line.addLineToPoint(CGPointMake(points[number].last!.x, CGRectGetHeight(scrollView.frame) - bottomGutterSize))
        
        let lineShape = CAShapeLayer()
        lineShape.path = line.CGPath
        lineShape.fillColor = colors[number].colorWithAlphaComponent(0.65).CGColor
        scrollView.layer.addSublayer(lineShape)
    }
    
    public func addDotsToGraph(number:Int) {
        for incrementer in 0..<points[number].count {
            let circle = UIView(frame: CGRectMake(0, 0, 5, 5))
            circle.backgroundColor = colors[number]
            circle.layer.cornerRadius = CGRectGetWidth(circle.frame) / 2
            circle.center = points[number][incrementer]
            scrollView.addSubview(circle)
        }
    }

}