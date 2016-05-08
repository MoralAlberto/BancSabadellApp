//
//  ArticleCellViewModel.swift
//  Boomerang
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
    var producto: String?
    var iban: String?
    
    func configureWithArticle(article: BancSabadellModel, atIndexPath indexPath: NSIndexPath) {
        self.account = article
        
        self.balance = article.balance
        self.indexPath = indexPath
        self.descriptionAccount = article.descriptionAccount
        self.producto = article.producto
        self.iban = article.iban
        
        delegate.updateViews()
    }
    
}