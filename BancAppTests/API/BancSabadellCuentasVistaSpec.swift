//
//  BancAppTests.swift
//  BancAppTests
//
//  Created by Alberto Moral on 5/5/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//


@testable import BancApp
import OHHTTPStubs
import Quick
import Nimble

class BancSabadellCuentasVistaSpec: QuickSpec {
    override func spec() {
        
        let accountResource: Resource<AccountsModel> = Resource(pathComponent: "\(APIConstants.APIEndPoint()!+APIConstants.APIPathAccounts()!)")
        
        describe("Retrieve CuentasVista") {
            
            let rootViewModel = RootViewModel()
            
            context("When we have a valid token", {

                let expectation = self.expectationWithDescription("Get Cuentas Vista")
                
                OHHTTPStubs.stubRequestsPassingTest({ (request: NSURLRequest) -> Bool in
                    return request.URL?.absoluteString == "https://developers.bancsabadell.com/ResourcesServerBS/oauthservices/v1.0.0/cuentasvista"
                }) { (request: NSURLRequest) -> OHHTTPStubsResponse in
                    let pathResponse = OHPathForFile("response.json", self.dynamicType)
                    return OHHTTPStubsResponse(fileAtPath: pathResponse!, statusCode: 200, headers: ["Content-Type":"application/json"])
                }
                
                rootViewModel.createCall(withResource: accountResource) { boolean in
                    expectation.fulfill()
                }
                
                it("The accounts received are two", closure: {
                    self.waitForExpectationsWithTimeout(20) { error in
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        }
                        //  In Objective-C is used isKindOfClass to check the property
                        expect(rootViewModel.messages.count == 2).to(beTrue())
                        OHHTTPStubs.removeAllStubs()
                        
                    }
                })
            })
        }
    }
}


