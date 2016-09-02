//
//  BancSabadellModelSpec.swift
//  BancApp
//
//  Created by Alberto Moral on 9/5/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
@testable import BancApp
import Quick
import Nimble


class BancSabadellModelSpec: QuickSpec {
    override func spec() {
        
        let bancSabadellModel = BancSabadellModel()
        
        describe("BancSabadellModel") { 
            context("has a property: ", {
                it("Balance and is a String", closure: {
                    //  In Objective-C is used isKindOfClass to check the property
                    expect(bancSabadellModel.balance is String?).to(beTrue())
                })
                
                it("DescriptionAccount and is a String", closure: {
                    expect(bancSabadellModel.descriptionAccount is String?).to(beTrue())
                })
                
                it("Producto and is a String", closure: {
                    expect(bancSabadellModel.product is String?).to(beTrue())
                })
                
                it("Iban and is a String", closure: {
                    expect(bancSabadellModel.iban is String?).to(beTrue())
                })
            })
        }
    }
}


