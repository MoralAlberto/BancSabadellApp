//
//  OptionCell.swift
//  Boomerang
//
//  Created by Alberto Moral on 24/2/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import UIKit
//import ReactiveCocoa

class OptionCell: UITableViewCell, OptionCellViewModelDelegate {
    

    @IBOutlet weak var name: UILabel!
    
    var indexPath: NSIndexPath?
    var viewModel = OptionCellViewModel()
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.delegate = self
    }
    
    //MARK: Update View
    func updateView() {
        name.text = viewModel.optionName
        indexPath = viewModel.indexPath
    }
}