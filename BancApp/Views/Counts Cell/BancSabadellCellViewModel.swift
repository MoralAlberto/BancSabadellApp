//
//  ArticleCellViewModel.swift
//  BancApp
//
//  Created by Alberto on 3/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import UIKit

protocol BancSabadellCellViewModelDelegate {
    func updateViews()
}

class BancSabadellCellViewModel: NSObject {
    
    var account: BancSabadellModel?
    
    var delegate: BancSabadellCellViewModelDelegate!
    var indexPath: NSIndexPath?
    var balance: String?
    var descriptionAccount: String?
    var product: String?
    var iban: String?
    
    func configureCellWithObject(object: BancSabadellModel, atIndexPath indexPath: NSIndexPath) {
        self.account = object
        
        self.balance = object.balance
        self.indexPath = indexPath
        self.descriptionAccount = object.descriptionAccount
        self.product = object.product
        self.iban = object.iban
        
        delegate.updateViews()
    }
}
