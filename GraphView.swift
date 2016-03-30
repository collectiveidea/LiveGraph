//
//  GraphView.swift
//  [i]Kegerator
//
//  Created by Ben Lambert on 8/31/15
//  Copyright © 2015 Collective Idea. All rights reserved.
//

import UIKit

public class GraphView: UIView {
    var scrollView:UIScrollView!
    
    public var xValues = [String]()
    public var yValues = [[Float]]()
    
    var leftGutterSize:CGFloat!
    var bottomGutterSize:CGFloat!
    var topGutterSize:CGFloat!
    var maxYSteps:Int!
    var yStepIncrement:Float!
    var yMeasurement:Float!
    var xValuesDistanceApart:CGFloat = 45
    var xPositions = [CGFloat]()
    private var yValuesDistanceApart:CGFloat!
    var points = [[CGPoint]]()
    var colors:[UIColor]!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func plotGraph(xVals:[String], yVals:[[Float]]) {
        destroyOldGraph()
        
        if xVals.isEmpty {
            xValues = ["•","•","•","•","•","•","•"]
        } else {
            xValues = xVals
        }
        if yVals.isEmpty {
            yValues = [[0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0]]
        } else {
            yValues = yVals
        }
        if maxYSteps == nil {
            maxYSteps = 6
        }
        if leftGutterSize == nil {
            leftGutterSize = 36.0
        }
        if bottomGutterSize == nil {
            bottomGutterSize = 30.0
        }
        if topGutterSize == nil {
            topGutterSize = 15.0
        }
        if colors == nil {
            var colorArray = [UIColor]()
            if yValues.count < 2 {
                colorArray += [UIColor(red: 251.0/255.0, green: 246.0/255.0, blue: 0.0/255.0, alpha: 1)]
                colorArray += [UIColor(red: 24.0/255.0, green: 193.0/255.0, blue: 215.0/255.0, alpha: 1)]
                colors = colorArray
            } else {
                for number in 0..<yValues.count {
                    if number % 2 == 0 {
                        colorArray += [UIColor(red: 251.0/255.0, green: 246.0/255.0, blue: 0.0/255.0, alpha: 1)]
                    } else {
                        colorArray += [UIColor(red: 24.0/255.0, green: 193.0/255.0, blue: 215.0/255.0, alpha: 1)]
                    }
                }
                colors = colorArray
            }
        }
        
        scrollView = UIScrollView(frame: CGRect(x: leftGutterSize!, y: 0, width: CGRectGetWidth(frame) - leftGutterSize!, height: CGRectGetHeight(frame)))
        scrollView.alwaysBounceHorizontal = true
        scrollView.scrollEnabled = true
        addSubview(scrollView)
        
        yValuesDistanceApart = (CGRectGetHeight(scrollView.frame) - bottomGutterSize! - topGutterSize!) / CGFloat(maxYSteps!)
        
        calculateTotalYDistance()
        
        addYValues()
        addXVals()
        
        plotPoints()
    }
    
    private func calculateTotalYDistance() {
        let maxYStepsFloat = Float(maxYSteps)
        var highestYVal:Float = 0
        var valueToCompare:Float = 0
            for number in 0..<yValues.count {
                guard !yValues[number].isEmpty else {
                    continue
                }
                valueToCompare = yValues[number].maxElement()!
                if valueToCompare > highestYVal {
                    highestYVal = valueToCompare
                }
            }
        
        let remainder = highestYVal % maxYStepsFloat
        yMeasurement = highestYVal - remainder + maxYStepsFloat
        yStepIncrement = yMeasurement / maxYStepsFloat
    }
    
    private func addYValues() {
        if let maxYSteps = maxYSteps {
            for number in 1...maxYSteps {
                let label = UILabel(frame: CGRectMake(0, 0, leftGutterSize, 20))
                label.text = "\(Int(yStepIncrement! * Float((number))))"
                label.textColor = UIColor.whiteColor()
                label.font = UIFont(name: "SourceSansPro-LightIt", size: 14)
                label.textAlignment = .Center
                label.center = CGPointMake(scrollView.frame.origin.x - CGRectGetWidth(label.frame) / 2, CGRectGetHeight(scrollView.frame) - yValuesDistanceApart * CGFloat(number) - bottomGutterSize) //start from the bottom
                addSubview(label)
                
                addHorizontalIndicator(label.center.y)
            }
        }
    }
    
    private func addHorizontalIndicator(yVal:CGFloat) {
        let line = UIBezierPath()
        let startingPoint = CGPointMake(scrollView.frame.origin.x, yVal)
        let endingPoint = CGPointMake(scrollView.frame.origin.x + CGRectGetWidth(frame) * 0.93, yVal)
        line.moveToPoint(startingPoint)
        line.addLineToPoint(endingPoint)
        
        let lineShape = CAShapeLayer()
        lineShape.path = line.CGPath
        lineShape.lineWidth = 1
        lineShape.strokeColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1).CGColor
        lineShape.fillColor = UIColor.clearColor().CGColor
        let dashes:[CGFloat] = [line.lineWidth, line.lineWidth * 6]
        lineShape.lineDashPattern = dashes
        
        layer.insertSublayer(lineShape, below: scrollView.layer)
    }
    
    private func addXVals() {
        var tempXPositions = [CGFloat]()
        for number in 0..<xValues.count {
            let label = UILabel(frame: CGRectMake(0, 0, 50, 20))
            label.text = "\(xValues[number])"
            label.textColor = UIColor.whiteColor()
            label.font = UIFont(name: "SourceSansPro-LightIt", size: 14)
            label.textAlignment = .Center
            tempXPositions += [xValuesDistanceApart * CGFloat(number) + xValuesDistanceApart / 2]
            label.center = CGPointMake( tempXPositions[number], CGRectGetHeight(frame) - bottomGutterSize / 2) //start from the bottom
            scrollView.addSubview(label)
        }
        xPositions = tempXPositions
        scrollView.contentSize = CGSizeMake(CGFloat(xPositions.count) * xValuesDistanceApart, 0)
    }
    
    private func plotPoints() {
        points.removeAll()
        for number in 0..<yValues.count {
            
            guard (!yValues[number].isEmpty) else {
                return
            }
            var pointsForGraph = [CGPoint]()
            for incrementer in 0..<yValues[number].count {
                let yDelta = CGRectGetHeight(scrollView.frame) - bottomGutterSize - topGutterSize
                let yPercentage = CGFloat(yValues[number][incrementer] / yMeasurement)
                if xPositions.count > incrementer {
                    pointsForGraph += [CGPoint(x: xPositions[incrementer], y: CGRectGetHeight(scrollView.frame) - yDelta * yPercentage - bottomGutterSize)]
                }
            }
            points += [pointsForGraph]
        }
        createGraphSection()
    }
    
    private func destroyOldGraph() {
        subviews.forEach{ $0.removeFromSuperview() }
    }
    
    func createGraphSection() {
        //override in subclass
    }
}
