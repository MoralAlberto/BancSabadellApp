//
//  RootViewModel.swift
//  BancApp
//
//  Created by Alberto Moral on 5/5/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import UIKit

class RootViewModel: NSObject {
    
    //
    
    let maxChars: UInt = 256
    let estimateRowHeight: CGFloat = 85.0
    
    //
    var users: NSArray = ["Cuentas", "Cuenta #1", "Cuenta #2"]
    var searchResult = NSArray()
    var messages = [BancSabadellModel]()
    
    //
    
    let articleCellNibName = "BancSabadellCell"
    let articleCellReuseIdentifier = "bancSabadellCell"
    
    let optionsCellNibName = "OptionCell"
    let optionsCellReuseIdentifier = "AutoCompletionCell"
    
    let detectAutocompletion = ["#"]
    
    /// MARK: Methods
    func arrayWithCoincidences(prefix: String, word: String) -> [String]? {
        
        searchResult = [String]()
        
        guard prefix == "#" else {
            return nil
        }
        
        if (prefix == "#") {
            let arrayWithAutocompletion = (word.characters.count > 0) ?
                users.filteredArrayUsingPredicate(NSPredicate(format:"self BEGINSWITH[c] %@", word)) as! [String]
                :
                users as! [String]
            
            searchResult = NSArray(array: arrayWithAutocompletion)
            return arrayWithAutocompletion
        } else {
            return nil
        }
    }
    
    func showAutocompletation() -> Bool {
        return searchResult.count > 0
    }
    
    func detectOptionSelected(prefix: String, range: NSRange, atIndexPath indexPath: NSIndexPath) -> String {
        
        let optionName = searchResult[indexPath.row] as? String
        
        if (prefix == "#" && range.location == 0) {
            
            if (optionName == "Cuentas") {
//                BancSabadellManager.login()
//                BancSabadellManager.cuentasVista()
                print("OPtion #1")
            } else if (optionName == "Cuenta #1") {
                    print("Option #2")
//                if (PocketManager.pocketToken() == nil) {
//                    PocketManager.login()
//                        .observeOn(UIScheduler())
//                        .startWithNext({ success in
//                            
//                            self.getArticles()
//                        })
//                } else {
//                    self.getArticles()
//                }
            } else if (optionName == "Cuenta #2"){
                print("OPtion #3")
            }
        }
        
        return optionName!
    }
}
