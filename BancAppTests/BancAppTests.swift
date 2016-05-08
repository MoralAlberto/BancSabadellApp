//
//  BancAppTests.swift
//  BancAppTests
//
//  Created by Alberto Moral on 5/5/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import XCTest
@testable import BancApp
import OHHTTPStubs

class BancAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatRetrieveAccessToken() {
        let rootViewModel = RootViewModel()
        let accountResource: Resource<AccountsModel> = Resource(pathComponent: "\(APIConstants.APIEndPoint()!+APIConstants.APIPathAccounts()!)")
        
        let expectation = expectationWithDescription("Get Characters")


        OHHTTPStubs.stubRequestsPassingTest({ (request: NSURLRequest) -> Bool in
            return request.URL?.absoluteString == "https://developers.bancsabadell.com/ResourcesServerBS/oauthservices/v1.0.0/cuentasvista"
        }) { (request: NSURLRequest) -> OHHTTPStubsResponse in
            let pathResponse = OHPathForFile("response.json", self.dynamicType)
            return OHHTTPStubsResponse(fileAtPath: pathResponse!, statusCode: 200, headers: ["Content-Type":"application/json"])
        }
        
        rootViewModel.createCall(withResource: accountResource) { boolean in
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(100) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            XCTAssertEqual(rootViewModel.messages.count, 2, "Should be two the number of accounts received")
        }
        
    }
}
