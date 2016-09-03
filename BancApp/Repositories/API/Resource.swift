//
//  Resource.swift
//  BancSabadellAPIKit
//
//  Created by Alberto Moral on 30/4/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ObjectMapper
import OAuthSwift

enum ResponseType: String {
    case code
}

struct Resource<A> {
    let pathComponent: String
    let oauthswift = OAuth2Swift(
            consumerKey:    APIConstants.APIClientId()!,
            consumerSecret: APIConstants.APIClientSecret()!,
            authorizeUrl:   APIConstants.APIPathOAuthURL()!,
            accessTokenUrl: APIConstants.APIPathOAuthURLAccessToken()!,
            responseType:   ResponseType.code.rawValue
    )
}

extension Resource {
    
    /**
     Initiates the request to the server
     
     - Parameters:
     - toClass: the class to be parsed when we receive data
     - callback: handle the result in an upper layer
     
     - Returns: Void
     */
    func loadAsynchronous<A: Mappable>(toClass: A.Type, callback: A -> ())  {
        let tokenExpirationDate = NSUserDefaults.standardUserDefaults().objectForKey("token_expires_at") as? NSDate
        guard let token = NSUserDefaults.standardUserDefaults().objectForKey("token") as? String where
            tokenExpirationDate > NSDate() else {
            
            //  If the token hasn't been created, login to BancSabadell portal or has been expired
            WebService.login(oauthswift)
            return
        }
        
        print("Token expiration Date \(tokenExpirationDate)")
        
        //  If the token has been created, get the info from the server
        WebService.makeAPICallWith(oauthswift, pathComponent: pathComponent, token: token, toClass: toClass, callback: callback)
    }
}
