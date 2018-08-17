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
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testFetchEvents() {
        
        let dateString = Date().convertToString(format: "yyyy-M-d")
        let promise = expectation(description: "Fetched data successfully")

        AlamofireManager.fetchURL(url: "https://webservices.vividseats.com/rest/mobile/v1/home/cards", param: ["startDate": dateString,"endDate": "2018-8-18","includeSuggested": "true"], completion: {  data in
            if(data.count > 0){
            promise.fulfill()
            }else{
            XCTFail("Error: No data")
            }
            
        })
         waitForExpectations(timeout: 5, handler: nil)

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
