//
//  MessageCell.swift
//  Boomerang
//
//  Created by Alberto Moral on 20/2/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import UIKit

protocol ArticleCellDelegate: class {
    func openURL(url: String)
}


class BancSabadellCell: UITableViewCell, BancSabadellCellViewModelDelegate {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var source: UILabel!
    
    var viewModel = BancSabadellCellViewModel()
    var sourceURL: String?
    var indexPath: NSIndexPath?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .None
        viewModel.delegate = self
    }
    
    func updateViews() {
        self.title.text = viewModel.account!.balance
        self.indexPath = viewModel.indexPath
        self.summary.text = viewModel.account!.descriptionAccount
        self.source.text = viewModel.account?.iban
    }
}
