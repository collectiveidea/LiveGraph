//
//  GraphViewTests.swift
//  LiveGraph
//
//  Created by Chris Rittersdorf on 3/29/16.
//  Copyright © 2016 Collective Idea. All rights reserved.
//

import XCTest

class GraphViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDefaultValues() {
        let subject = GraphView()
        
        XCTAssertEqual(subject.xValues, ["•","•","•","•","•","•","•"])
        XCTAssertEqual(subject.yValues, [[0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0]])
        XCTAssertEqual(subject.maxYSteps, 6)
        XCTAssertEqual(subject.leftGutterSize, 36.0)
        XCTAssertEqual(subject.bottomGutterSize, 30.0)
        XCTAssertEqual(subject.topGutterSize, 15.0)
    }
    
    
    func testSettingWindow() {
        // Setting a window will only show the most recent yValues
        let xVals = ["one", "two", "three", "four", "five"]
        let yVals: [[Float]] = [[1.0, 2.0, 3.0, 4.0, 5.0], [2.0, 4.0, 6.0, 8.0, 10.0]]
        
        let subject = GraphView()
        subject.dataWindow = 3 // Limit the plotting to 3 points per line
        
        subject.plotGraph(xVals, yVals: yVals)
        
        XCTAssertEqual(subject.xValues, ["three", "four", "five"])
        XCTAssertEqual(subject.yValues[0], [3.0, 4.0, 5.0])
        XCTAssertEqual(subject.yValues[1], [6.0, 8.0, 10.0])
    }
}
