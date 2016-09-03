//
//  WebService.swift
//  BancSabadellAPIKit
//
//  Created by Alberto Moral on 3/9/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ObjectMapper
import OAuthSwift

class WebService {
    
    /**
     Creates a new Generic API REST call with
     
     - Parameters:
     - oauthswift: to handle the request (previous created in an upper layer Resource)
     - pathComponent: the URL to get all the information
     - token: a valid token
     - toClass: the class to be parsed when we receive data
     - params: custom params to send in our POST
     - callback: handle the result in an upper layers
     
     - Returns: Void
     */
    static func makeAPICallWith<A: Mappable>(oauthswift: OAuth2Swift,
                                pathComponent: String,
                                token: String,
                                params: [String: String]? = nil,
                                toClass: A.Type,
                                callback: A -> ()) {
        
        oauthswift.startAuthorizedRequest(
            pathComponent,
            method: .POST,
            parameters: [:],
            headers: headerResource(token),
            success: { (data, response) in
                guard let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) else { return }
                let result = Mapper<A>().map(json)
                print(json)
                callback(result!)
        }) { (error) in
            //  If there is an error, we need to refresh that token
            print("Error \(error)")
        }
    }
    
    /**
     Login the user, and store all the important values to check later
     
     - Parameters:
     - oauthswift: to handle the request (previous created in an upper layer Resource)
     */
    static func login(oauthswift: OAuth2Swift) {
        
        oauthswift.accessTokenBasicAuthentification = true
        let state: String = generateStateWithLength(16) as String
        
        oauthswift.authorizeWithCallbackURL(
            NSURL(string: "BancApp://oauth-callback")!,
            scope: "read+auth", state: state,
            success: { credential, response, parameters in
                NSUserDefaults.standardUserDefaults().setObject(credential.oauth_token, forKey: "token")
                NSUserDefaults.standardUserDefaults().setObject(credential.oauth_refresh_token, forKey: "refresh_token")
                NSUserDefaults.standardUserDefaults().setObject(credential.oauth_token_expires_at, forKey: "token_expires_at")
                NSUserDefaults.standardUserDefaults().synchronize()
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
    }
    
    /**
     Refresh an invalid token
     
     - Parameters:
     - oauthswift: to handle the request (previous created in an upper layer Resource)
     */
    static func refreshToken(oauthswift: OAuth2Swift) {
        let base64Encoded = base64EncodedString()
        let headers = headerRefreshToken(base64Encoded)
        let params = paramsRefreshToken()
        
        oauthswift.startAuthorizedRequest(
            APIConstants.APIPathOAuthURLAccessToken()!,
            method: .POST,
            parameters: params,
            headers: headers,
            success: { (data, response) in
                
                guard let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) else { return }
                
                self.updateCredentials(json)
        }) { (error) in
            WebService.login(oauthswift)
        }
    }
}

extension WebService {
    static func headerResource(token: String) -> [String: String] {
        let headers = ["Accept": "application/json, application/x-www-form-urlencoded",
                       "Authorization" : "Bearer \(token)"]
        return headers
    }
    
    static func headerRefreshToken(base64Encoded: String) -> [String: String] {
        let headers = ["Authorization"  : "Basic \(base64Encoded)",
                       "Content-Type"   : "text/html"]
        return headers
    }
    
    static func paramsRefreshToken() -> [String: String] {
        let refreshToken = NSUserDefaults.standardUserDefaults().objectForKey("refresh_token") as! String
        let params = ["client_id"       : APIConstants.APIClientId()!,
                      "client_secret"   : APIConstants.APIClientSecret()!,
                      "refresh_token"   : refreshToken,
                      "grant_type"      : "refresh_token"
        ]
        return params
    }
    
    
    static func base64EncodedString() -> String {
        let clientId_ClientSecret = APIConstants.APIClientId()!+":"+APIConstants.APIClientSecret()!
        let authentification = clientId_ClientSecret.dataUsingEncoding(NSUTF8StringEncoding)
        let base64Encoded = authentification?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        return base64Encoded!
    }
    
    static func updateCredentials(json: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(json["access_token"] as! String, forKey: "token")
        NSUserDefaults.standardUserDefaults().setObject(json["refresh_token"] as! String, forKey: "refresh_token")
        NSUserDefaults.standardUserDefaults().setObject(json["expires_in"] as! NSNumber, forKey: "expires_in")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
