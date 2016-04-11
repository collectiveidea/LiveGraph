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
    
    public var dataWindow: Int?
    
    public var xValues:[String] = ["•","•","•","•","•","•","•"]
    public var yValues:[[Float]] = [[0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0]]
    public var maxYSteps:Int! = 6
    public var colors:[UIColor]! = GraphView.defaultColors(2)
    
    public var leftGutterSize:CGFloat! = 36.0
    public var bottomGutterSize:CGFloat! = 30.0
    public var topGutterSize:CGFloat! = 15.0
    
    var yStepIncrement:Float!
    var yMeasurement:Float!
    var xValuesDistanceApart:CGFloat = 45
    var xPositions = [CGFloat]()
    private var yValuesDistanceApart:CGFloat!
    var points = [[CGPoint]]()
    
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public static func defaultColors(size: Int) -> [UIColor] {
        var colorArray = [UIColor]()
        if size < 2 {
            colorArray += [UIColor(red: 251.0/255.0, green: 246.0/255.0, blue: 0.0/255.0, alpha: 1)]
            colorArray += [UIColor(red: 24.0/255.0, green: 193.0/255.0, blue: 215.0/255.0, alpha: 1)]
        } else {
            for number in 0..<size {
                if number % 2 == 0 {
                    colorArray += [UIColor(red: 251.0/255.0, green: 246.0/255.0, blue: 0.0/255.0, alpha: 1)]
                } else {
                    colorArray += [UIColor(red: 24.0/255.0, green: 193.0/255.0, blue: 215.0/255.0, alpha: 1)]
                }
            }
        }
        
        return colorArray
    }
    
    public func setDataValues(xValues: [String], yValues: [[Float]]) {
        if (dataWindow != nil) {
            self.xValues = Array(xValues.suffix(dataWindow!))
            self.yValues = yValues.map({ ary in
                return Array(ary.suffix(dataWindow!))
            })
        } else {
            self.xValues = xValues
            self.yValues = yValues
        }
    }
    
    public func plotGraph(xVals:[String], yVals:[[Float]]) {
        destroyOldGraph()
        
        setDataValues(xVals, yValues: yVals)
        
        scrollView = UIScrollView(
            frame: CGRect(
                x: leftGutterSize!,
                y: 0, width: CGRectGetWidth(frame) - leftGutterSize!,
                height: CGRectGetHeight(frame)
            )
        )
        
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
