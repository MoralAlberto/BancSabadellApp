//
//  RootViewModel.swift
//  BancApp
//
//  Created by Alberto Moral on 5/5/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import UIKit

protocol RootViewModelDelegate {
    func updateView()
}

class RootViewModel: NSObject {
    
    //  Delegate
    var delegate: RootViewModelDelegate!
    
    // Vars
    let maxChars: UInt = 256
    let estimateRowHeight: CGFloat = 85.0
    
    // Override Variables
    var options: NSArray = ["Cuentas", "Tarjetas"]
    //  Symbol to Detect Autocompletion
    var detectAutocompletion: [String] = ["#"]
    
    var searchResult = NSArray()
    var messages = [BancSabadellModel]()
    
    // Cell Info
    let bancSabadellCellNibName = "BancSabadellCell"
    let bancSabadellCellReuseIdentifier = "bancSabadellCell"
    
    let optionsCellNibName = "OptionCell"
    let optionsCellReuseIdentifier = "AutoCompletionCell"

    
    // MARK: Public Methods
    func arrayWithCoincidences(prefix: String, word: String) -> [String]? {
        
        searchResult = [String]()
        
        guard prefix == "#" else { return nil }
        
        if (prefix == "#") {
            let arrayWithAutocompletion = (word.characters.count > 0) ?
                options.filteredArrayUsingPredicate(NSPredicate(format:"self BEGINSWITH[c] %@", word)) as! [String]
                :
                options as! [String]
            
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
        
        guard let optionName = searchResult[indexPath.row] as? String else { return "" }
        
        if (prefix == "#" && range.location == 0) {
            switch optionName {
            case "Accounts":
                print("Option #1")
                self.getAccounts()
            case "Cards":
                print("Option #2")
                self.getCards()
            default:
                print("No code")
            }
        }
        return optionName
    }
}

//MARK: - API calls

extension RootViewModel {
    func getAccounts() {
        let accountResource: Resource<AccountsModel> = Resource(pathComponent: "\(APIConstants.APIEndPoint()!+APIConstants.APIPathAccounts()!)")
        createCall(withResource: accountResource) { boolean in
            print("Finished? \(boolean)")
        }

    }
    
    func getCards() {
        let accountResource: Resource<AccountsModel> = Resource(pathComponent: "\(APIConstants.APIEndPoint()!+APIConstants.APIPathTargets()!)")
        createCall(withResource: accountResource) { boolean in
            print("Finished? \(boolean)")
        }
    }
    
    //  API Helpers
    
    func createCall(withResource accountResource: Resource<AccountsModel>, completionBlock: (Bool)->()) {
        accountResource.loadAsynchronous(AccountsModel.self) { x in
            print(x)
            
            guard let value = x.data else {
                completionBlock(true)
                return
            }
            
            for account in value {
                let newAccount = BancSabadellModel()
                newAccount.balance = account.balance
                newAccount.descriptionAccount = account.description
                newAccount.iban = account.iban
                newAccount.product = account.product
                
                self.messages.append(newAccount)
            }
            
            self.delegate?.updateView()
            completionBlock(true)
        }
    }
}

