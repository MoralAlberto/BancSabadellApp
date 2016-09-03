//
//  APIConstantsManager.swift
//  BancSabadellAPI
//
//  Created by Diana on 12/9/15.
//  Copyright (c) 2015 Moral. All rights reserved.
//

import Foundation

class APIConstantsManager {
    
    static var ApiConstants = "APIConstants"
    
    static func setupPlist() -> NSDictionary {
        let path = NSBundle.mainBundle().pathForResource(ApiConstants, ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        
        return dict!
    }
}

class APIConstants {
    
    static var ApiEndPoint = "APIEndPoint"
    static var ApiClientId = "APIClientID"
    static var ApiClientSecret = "APIClientSecret"
    
    static var ApiPathAccounts = "APIPaths.APIPathAccounts"
    static var ApiPathProducts = "APIPaths.APIPathProducts"
    static var ApiPathTargets = "APIPaths.APIPathTargets"
    
    static var ApiPathOAuthRefreshToken = "APIOAuth.APIPathRefreshToken"
    static var ApiPathOAuthURL = "APIOAuth.APIAuthorizeURL"
    static var ApiPathOAuthURLAccessToken = "APIOAuth.APIAccessTokenURL"
    
    
    static var valueDict: NSDictionary = APIConstantsManager.setupPlist() as NSDictionary
    
    static func APIEndPoint() -> String? {
        return valueDict[ApiEndPoint] as? String
    }
    
    static func APIClientId() -> String? {
        return valueDict[ApiClientId] as? String
    }
    
    static func APIClientSecret() -> String? {
        return valueDict[ApiClientSecret] as? String
    }
    
    static func APIPathAccounts() -> String? {
        return valueDict.valueForKeyPath(ApiPathAccounts) as? String
    }
    
    static func APIPathProducts() -> String? {
        return valueDict.valueForKeyPath(ApiPathProducts) as? String
    }
    
    static func APIPathOAuthRefreshToken() -> String? {
        return valueDict.valueForKeyPath(ApiPathOAuthRefreshToken) as? String
    }
    
    static func APIPathTargets() -> String? {
        return valueDict.valueForKeyPath(ApiPathTargets) as? String
    }
    
    static func APIPathOAuthURLAccessToken() -> String? {
        return valueDict.valueForKeyPath(ApiPathOAuthURLAccessToken) as? String
    }
    
    static func APIPathOAuthURL() -> String? {
        return valueDict.valueForKeyPath(ApiPathOAuthURL) as? String
    }
}
