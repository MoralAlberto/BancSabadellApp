//
//  RootViewModelSpec.swift
//  BancApp
//
//  Created by Alberto Moral on 9/5/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

@testable import BancApp
import OHHTTPStubs
import Quick
import Nimble


class BancSabadellCuentasVistaNoTokenSpec: QuickSpec {
    override func spec() {
        let rootViewModel = RootViewModel()
        
        describe("Root View Model") {
            
            context("Has different properties with different types", {
                it("maxChars and is a UInt", closure: {
                    //  In Objective-C is used isKindOfClass to check the property
                    expect(rootViewModel.maxChars is UInt?).to(beTrue())
                })
                
                it("estimateRowHeight and is a CGFloat", closure: {
                    //  In Objective-C is used isKindOfClass to check the property
                    expect(rootViewModel.estimateRowHeight is CGFloat?).to(beTrue())
                })
                
                it("searchResult and is a NSArray", closure: {
                    //  In Objective-C is used isKindOfClass to check the property
                    expect(rootViewModel.searchResult is NSArray?).to(beTrue())
                })
                
                it("bancSabadellCellNibName, bancSabadellCellReuseIdentifier, optionsCellNibName and optionsCellReuseIdentifier and are Strings", closure: {
                    //  In Objective-C is used isKindOfClass to check the property
                    expect(rootViewModel.bancSabadellCellNibName is String?).to(beTrue())
                    expect(rootViewModel.bancSabadellCellReuseIdentifier is String?).to(beTrue())
                    expect(rootViewModel.optionsCellNibName is String?).to(beTrue())
                    expect(rootViewModel.optionsCellReuseIdentifier is String?).to(beTrue())
                })
            })
            
            context("has different predefined variables like", { 
                it("options", closure: { 
                    expect(rootViewModel.options.count == 2).to(beTrue())
                })
                
                it("detectAutocompletion", closure: {
                    expect(rootViewModel.detectAutocompletion.last == "#").to(beTrue())
                })
                
                it("bancSabadellCellNibName", closure: {
                    expect(rootViewModel.bancSabadellCellNibName == "BancSabadellCell").to(beTrue())
                })
                
                it("bancSabadellCellReuseIdentifier", closure: {
                    expect(rootViewModel.bancSabadellCellReuseIdentifier == "bancSabadellCell").to(beTrue())
                })
                
                it("optionsCellNibName", closure: {
                    expect(rootViewModel.optionsCellNibName == "OptionCell").to(beTrue())
                })
                
                it("optionsCellReuseIdentifier", closure: {
                    expect(rootViewModel.optionsCellReuseIdentifier == "AutoCompletionCell").to(beTrue())
                })
                
                it("maxChars", closure: {
                    expect(rootViewModel.maxChars == 256).to(beTrue())
                })
                
                it("estimateRowHeight", closure: {
                    expect(rootViewModel.estimateRowHeight == 85).to(beTrue())
                })
            })
            
            context("Function arrayWithCoincidences", {
                
                rootViewModel.arrayWithCoincidences("#", word: "Cuentas")
                
                it("With param #Cuentas, return 'Cuentas'", closure: {
                    expect(rootViewModel.searchResult[0] as! String == "Cuentas").to(beTrue())
                })
                
                it("With param #Cuentas, one Object", closure: {
                    expect(rootViewModel.searchResult.count == 1).to(beTrue())
                })
                
            })
            
            //  Use OCMock with Verify and check that the delegate method is called.
            context("", { 
                
            })
        }
    }
}

