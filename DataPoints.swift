//
//  DataPoints.swift
//  LiveGraph
//
//  Created by Chris Rittersdorf on 3/29/16.
//  Copyright © 2016 Collective Idea. All rights reserved.
//

import Foundation

public protocol Plottable {
    var x: Float { get }
    var y: Float { get }
}

public struct Point: Plottable {
    public var x: Float
    public var y: Float
}

extension Array where Element: Plottable {
    mutating func liveAppend(item: Element, callback: (theItem: Point) -> Void) {
        append(item)
        callback(theItem: item as! Point)
    }
}

public typealias DataPoints = Array<Point>

public class PointGenerator: GeneratorType {
    public typealias Element = Point
    
    var dataPoints = DataPoints()
    
    var currentX = Float(0.0)
    var currentY = Float(0.0)
    
    public func next() -> Element? {
        currentX += 1.0
        currentY += 1.0
        
        if currentY > 10.0 {
            currentY = 0
        }
        
        return Point(x: currentX, y: currentY)
    }
}
