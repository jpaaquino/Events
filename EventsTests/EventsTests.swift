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
    
    func testViewModel(){
        let event = Event(topLabel: "Top Label", middleLabel: "middle label", bottomLabel: "bottom label", entityId: 1, eventCount: 10, targetId: 75, targetType: "target type", startDate: 100, rank: 5, entityType: "entity type", image: "http://www.google.com")
        let viewModel = EventViewModel(event: event)
        XCTAssertEqual(event.topLabel, viewModel.topLabel)
        XCTAssertEqual(event.middleLabel, viewModel.middleLabel)
        XCTAssertEqual(event.bottomLabel, viewModel.bottomLabel)
        XCTAssertEqual(event.entityId, viewModel.entityId)
        XCTAssertEqual(event.eventCount, viewModel.eventCount)
        XCTAssertEqual(event.targetId, viewModel.targetId)
        XCTAssertEqual(event.targetType, viewModel.targetType)
        XCTAssertEqual(event.startDate, viewModel.startDate)
        XCTAssertEqual(event.rank, viewModel.rank)
        XCTAssertEqual(event.entityType, viewModel.entityType)
        XCTAssertEqual(event.image, viewModel.image)
        XCTAssertNotNil(viewModel.imageURL)

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
