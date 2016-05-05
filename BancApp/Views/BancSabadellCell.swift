//
//  MessageCell.swift
//  Boomerang
//
//  Created by Alberto Moral on 20/2/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import UIKit
//import ReactiveCocoa
//import MGSwipeTableCell

protocol ArticleCellDelegate: class {
    func openURL(url: String)
}

//class ArticleCell: MGSwipeTableCell, MGSwipeTableCellDelegate {
class BancSabadellCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var source: UILabel!
    
    var viewModel = BancSabadellCellViewModel()
    var sourceURL: String?
    var indexPath: NSIndexPath?
    
    weak var ownDelegate: ArticleCellDelegate?

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        selectionStyle = .None
//        delegate = self
//        
//        //  ViewModel with View
//        binding()
//
//        //  Actions
//        addActionToSummaryLabel()
//        
//        configureRightButtons("favorite")
//        configureLeftButtons()
//    }
//    
//    /// MARK: Setup
//    func binding() {
//        RACObserve(viewModel, "isReady")
//            .ignore(false)
//            .subscribeNext { (anyObject: AnyObject!) -> Void in
//                self.summary.text = self.viewModel.summary
//                self.indexPath = self.viewModel.indexPath
//                self.title.text = self.viewModel.title
//                self.sourceURL = self.viewModel.sourceURL
//                
//                if let x = self.viewModel.baseURL?.host, b = self.viewModel.nameImageFavorite {
//                    self.source.text =  x
//                    self.configureRightButtons(b)
//                }
//        }
//    }
//    
//    func configureRightButtons(nameImageFav: String) {
//        
//        let imageFavorite = UIImage(named: nameImageFav)
//
//        let archive = MGSwipeButton(title: "", icon: UIImage(named:"archive"), backgroundColor: UIColor(red: 245.0/255, green: 245.0/255, blue: 245.0/255, alpha: 1.0))
//        let favorite = MGSwipeButton(title: "", icon: imageFavorite, backgroundColor: UIColor(red: 245.0/255, green: 245.0/255, blue: 245.0/255, alpha: 1.0))
//        let delete = MGSwipeButton(title: "", icon: UIImage(named:"delete"), backgroundColor: UIColor(red: 245.0/255, green: 245.0/255, blue: 245.0/255, alpha: 1.0))
//        
//        //configure left buttons
//        rightButtons = [archive, favorite, delete]
//        rightSwipeSettings.transition = MGSwipeTransition.Drag
//    }
//    
//    func configureLeftButtons() {
//        let twitter = MGSwipeButton(title: "", icon: UIImage(named: "twitter"), backgroundColor: UIColor(red: 245.0/255, green: 245.0/255, blue: 245.0/255, alpha: 1.0))
//        let facebook = MGSwipeButton(title: "", icon: UIImage(named: "facebook"), backgroundColor: UIColor(red: 245.0/255, green: 245.0/255, blue: 245.0/255, alpha: 1.0))
//        
//        leftButtons = [twitter, facebook]
//        leftSwipeSettings.transition = MGSwipeTransition.Drag
//    }
//    
//    
//    func addActionToSummaryLabel() {
//        let tap = UITapGestureRecognizer(target: self, action: Selector("openURL:"))
//        tap.cancelsTouchesInView = false
//        self.summary.userInteractionEnabled = true
//        self.summary.addGestureRecognizer(tap)
//    }
//
//    /// MARK: Delegate
//    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
//        print("Hola \(index)")
//        
//        if index == 1 {
//            print("Pulsado favorito")
//            viewModel.addThisArticleToFav()
//        }
//        
//        return true
//    }
//    
//    
//    /// MARK: Actions
//    func openURL(recognizer: UITapGestureRecognizer) {
//        print("The handsfree image was tapped \(viewModel.favorite)")
////        self.ownDelegate!.openURL(self.sourceURL!)
//    }
    

    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        
//        title.text = nil
//        summary.text = nil
//        sourceURL = nil
//    }
}
