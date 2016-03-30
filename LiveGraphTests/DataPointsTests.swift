//
//  DataPointsTests.swift
//  LiveGraph
//
//  Created by Chris Rittersdorf on 3/29/16.
//  Copyright © 2016 Collective Idea. All rights reserved.
//

import XCTest

class DataPointsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPoint() {
        let p1 = Point(x: 1.0, y: 2.0)
        XCTAssertEqual(p1.x, 1.0)
        XCTAssertEqual(p1.y, 2.0)
    }
    
    func testInit() {
        let subject = DataPoints()
        
        XCTAssertNotNil(subject)
        XCTAssertEqual(subject.count, 0)
    }
    
    func testInitWithArray() {
        let p1 = Point(x: 1.0, y: 2.0)
        let p2 = Point(x: 0.0, y: 0.0)

        let subject = DataPoints(arrayLiteral: p1, p2)
        XCTAssertEqual(subject.count, 2)
    }
    
    func testLiveAppend() {
        let callbackExpectation = expectationWithDescription("callbackExpectation")
        
        var subject = DataPoints()
        
        let p1 = Point(x: 1.0, y: 2.0)

        subject.liveAppend(p1) { theItem in
            XCTAssertEqual(theItem.x, p1.x)
            XCTAssertEqual(theItem.y, p1.y)
            
            callbackExpectation.fulfill()
        }
        
        
        waitForExpectationsWithTimeout(1) { (error: NSError?) in
            XCTAssertNil(error, "Something went wrong")
        }
    }
}
