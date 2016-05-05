//
//  OptionCell.swift
//  Boomerang
//
//  Created by Alberto Moral on 24/2/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import UIKit
//import ReactiveCocoa

class OptionCell: UITableViewCell {
    

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
        
//        binding()
    }
    
//    func binding(){
//        RACObserve(viewModel, "isReady")
//            .ignore(false)
//            .subscribeNext { name in
//                self.name.text = self.viewModel.optionName
//                self.indexPath = self.viewModel.indexPath
//            }
//        }
}