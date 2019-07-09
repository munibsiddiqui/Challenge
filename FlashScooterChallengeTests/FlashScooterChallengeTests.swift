//
//  FlashScooterChallengeTests.swift
//  FlashScooterChallengeTests
//
//  Created by Munib Siddiqui on 09/07/2019.
//  Copyright © 2019 Munib Siddiqui. All rights reserved.
//

import XCTest
@testable import FlashScooterChallenge

class FlashScooterChallengeTests: XCTestCase {

    var viewModel : MapViewModel? = nil
    
    override func setUp() {
        viewModel = MapViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testVehicle_AllVehicle () {
        
        // Create an expectation
        let expectation = self.expectation(description: "FetchingVehicles")

        viewModel?.fetchAllVehicles {
            
             expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue((viewModel?.vehicles.count)! > 0, "No Vehicles Found");

    }

    
}
