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
    

}
