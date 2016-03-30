//: Playground - noun: a place where people can play

import UIKit


protocol Plottable {
    var x: Float { get }
    var y: Float { get }
}


struct Point: Plottable {
    var x: Float
    var y: Float
}

let lePoint = Point(x: 1.0, y: 2.0)

extension Array where Element: Plottable {
    mutating func liveAppend(item: Element, callback: (theItem: Element.Type) -> Void) {
        append(item)
    }
}

typealias DataPoints = Array<Plottable>



var points = DataPoints()

points.append(lePoint)
points.append(lePoint)
points.append(lePoint)
points.append(lePoint)


class PointGenerator: GeneratorType {
    typealias Element = Point
    
    var dataPoints = DataPoints()
    
    var currentX = Float(0.0)
    var currentY = Float(0.0)
    
    func next() -> Element? {
        currentX += 1.0
        currentY += 1.0
        
        return Point(x: currentX, y: currentY)
    }
}


let pg = PointGenerator()

pg.next()
pg.next()
pg.next()
pg.next()
pg.next()
pg.next()
