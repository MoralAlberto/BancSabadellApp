//
//  OptionCellViewModel.swift
//  Boomerang
//
//  Created by Alberto on 9/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation

class OptionCellViewModel: NSObject {
    
    var optionName: String?
    var indexPath: NSIndexPath?
    
    dynamic var isReady = ""
    
    func configureWithOption(name: String, atIndexPath indexPath: NSIndexPath) {
        self.optionName = name
        self.indexPath = indexPath
        self.isReady = ""
    }
}