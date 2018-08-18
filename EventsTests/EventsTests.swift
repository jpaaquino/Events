//
//  EventsTests.swift
//  EventsTests
//
//  Created by Joao Paulo Aquino on 2018-08-13.
//  Copyright © 2018 Joao Paulo Aquino. All rights reserved.
//

import XCTest
@testable import Events
@testable import Alamofire

class EventsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    
    override func tearDown() {
        super.tearDown()
    }

    
    func testFetchEvents() {
        
        let promise = expectation(description: "Fetched data successfully")

        AlamofireManager.fetchURL(completion: {  data in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertTrue(data.count > 0, "data should not be empty")
            promise.fulfill()
        })
        waitForExpectations(timeout: 8){ (error) in
            print(error?.localizedDescription ?? "timeout")
        }

    }
    
    func testPerformanceFetchEvents() {
        self.measure {
            let exp = expectation(description: "Fetch events")
            AlamofireManager.fetchURL(completion: {  data in
                exp.fulfill()
            })
            waitForExpectations(timeout: 8){ (error) in
                print(error?.localizedDescription ?? "timeout")
            }
        }
    }
    
}
