//
//  QuestionModel.swift
//  BancSabadellAPI
//
//  Created by Alberto Moral on 30/4/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ObjectMapper

class AccountsModel: Mappable {
    var data: [AccountModel]?
    
    required init?(_ map: Map) {}
    
    //  Mappable
    func mapping(map: Map) {
        data <- map["data"]
    }
}
