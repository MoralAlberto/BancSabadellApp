//
//  Items.swift
//  BancSabadellAPI
//
//  Created by Alberto Moral on 6/9/15.
//  Copyright (c) 2015 Moral. All rights reserved.
//

import Foundation
import ObjectMapper

class AccountModel: Mappable {
    var balance: String?
    var description: String?
    var product: String?
    var iban: String?
    
    required init?(_ map: Map) {}
    
    //  Mappable
    func mapping(map: Map) {
        description <- map["descripcion"]
        balance <- map["balance"]
        iban <- map["iban"]
        product <- map["producto"]
        
    }
}
