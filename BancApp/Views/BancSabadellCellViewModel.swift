//
//  ArticleCellViewModel.swift
//  Boomerang
//
//  Created by Alberto on 3/3/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import UIKit
//import ReactiveCocoa

class BancSabadellCellViewModel: NSObject {
    
    var article: BancSabadellModel?
    
    var id: String?
    var summary: String?
    var indexPath: NSIndexPath?
    var title: String?
    var sourceURL: String?
    var baseURL: NSURL?
    var favorite: String?
    var nameImageFavorite: String?
    
    dynamic var isReady = ""

    
    func configureWithArticle(article: BancSabadellModel, atIndexPath indexPath: NSIndexPath) {
        self.article = article
        
        self.summary = article.summary
        self.indexPath = indexPath
        self.title = article.title
        self.sourceURL = article.sourceURL
        self.favorite = article.favorite
        self.id = article.id
        
        if (article.favorite == "0") {
            self.nameImageFavorite = "favorite"
        } else {
            self.nameImageFavorite = "favorite_on"
        }
        
        self.baseURL = NSURL(string: article.sourceURL!)
        
        
        //  Notify the view
        self.isReady = "Valor"
    }
    
    
    func addThisArticleToFav() {
//        print("View model")
//        
//        let favOrNot: Bool = (self.favorite == "0") ? true : false
//        
//        PocketManager.favoriteArticle(favOrNot, articleID: self.id!)
//            .startWithNext { value in
//                print("receive response \(value)")
//                self.favorite = value
//                self.isReady = "Valor"
//        }
    }
}