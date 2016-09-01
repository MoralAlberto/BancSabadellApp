//
//  OptionCellViewModel.swift
//  BancApp
//
//  Created by Alberto on 9/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation

protocol OptionCellViewModelDelegate {
    func updateView()
}

class OptionCellViewModel: NSObject {
    
    var optionName: String?
    var indexPath: NSIndexPath?
    var delegate: OptionCellViewModelDelegate!
        
    func configureWithOption(name: String, atIndexPath indexPath: NSIndexPath) {
        self.optionName = name
        self.indexPath = indexPath
        
        delegate?.updateView()
    }
}
