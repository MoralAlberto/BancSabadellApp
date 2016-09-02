//
//  BancSabadellCuentasVistaNoTokenSpec.swift
//  BancApp
//
//  Created by Alberto Moral on 9/5/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

@testable import BancApp
import Quick
import Nimble


//class BancSabadellCuentasVistaNoTokenSpec: QuickSpec {
//    override func spec() {
//        
//        let accountResource: Resource<AccountsModel> = Resource(pathComponent: "\(APIConstants.APIEndPoint()!+APIConstants.APIPathAccounts()!)")
//        
//        describe("Retrive Cuentas Vista error token") {
//            
//            let rootViewModel = RootViewModel()
////            
////            afterEach({
////                OHHTTPStubs.removeAllStubs()
////            })
//            
//            context("When we have a invalid token", {
//                
//                let expectation = self.expectationWithDescription("Get Cuentas Vista")
//                
//                OHHTTPStubs.stubRequestsPassingTest({ (request: NSURLRequest) -> Bool in
//                    return request.URL?.absoluteString == "https://developers.bancsabadell.com/ResourcesServerBS/oauthservices/v1.0.0/cuentasvista"
//                }) { (request: NSURLRequest) -> OHHTTPStubsResponse in
//                    let pathResponse = OHPathForFile("response_error_token.json", self.dynamicType)
//                    return OHHTTPStubsResponse(fileAtPath: pathResponse!, statusCode: 200, headers: ["Content-Type":"application/json"])
//                }
//                
//                rootViewModel.createCall(withResource: accountResource) { boolean in
//                    expectation.fulfill()
//                }
//                
//                it("The accounts received are 0 because we have a NO valid token", closure: {
//                    self.waitForExpectationsWithTimeout(20) { error in
//                        if let error = error {
//                            print("Error: \(error.localizedDescription)")
//                        }
//                        //  In Objective-C is used isKindOfClass to check the property
//                        expect(rootViewModel.messages.count == 0).to(beTrue())
//                        OHHTTPStubs.removeAllStubs()
//                    }
//                })
//                
//                
//                
//            })
//            
//        }
//        
//    }
//}



