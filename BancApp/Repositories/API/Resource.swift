//
//  Resource.swift
//  DemoStackOverflow
//
//  Created by Alberto Moral on 30/4/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ObjectMapper
import OAuthSwift
import Prephirences

struct Resource<A> {
    let pathComponent: String
    
    let oauthswift = OAuth2Swift(
        consumerKey:    APIConstants.APIClientID()!,
        consumerSecret: APIConstants.APIClientSecret()!,
        authorizeUrl:   APIConstants.APIPathOAuthURL()!,
        accessTokenUrl: APIConstants.APIPathOAuthURLAccessToken()!,
        responseType:   "code"
    )
    
    var clientID_clientSecret: String {
        return APIConstants.APIClientID()!+":"+APIConstants.APIClientSecret()!
    }
}

extension Resource {
    func loadAsynchronous<A: Mappable>(toClass: A.Type, callback: A -> ())  {
        guard let token = NSUserDefaults.standardUserDefaults().objectForKey("token") as? String else {
            //  Si no existe el token, carga la web para logearme
            login()
            return
        }
        //  Si existe el token, haz la llamada a la API
        let header = headerResource(token)
        
        makeAPICallWith(header, toClass: toClass, callback: callback)
    }
    
    func makeAPICallWith<A: Mappable>(header: [String: String], params: [String: String]? = nil, toClass: A.Type, callback: A -> ()) {
        oauthswift.startAuthorizedRequest(
            pathComponent,
            method: .POST,
            parameters: [:],
            headers: header,
            success: { (data, response) in
                guard let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) else { return }
                let result = Mapper<A>().map(json)
                print(json)
                callback(result!)
        }) { (error) in
            //  If there is an error, we need to refresh that token
        }
    }
    
    
    func login() {
        oauthswift.accessTokenBasicAuthentification = true
        let state: String = generateStateWithLength(16) as String
        
        oauthswift.authorizeWithCallbackURL(
            NSURL(string: "BancApp://oauth-callback")!,
            scope: "read+auth", state: state,
            success: { credential, response, parameters in
                // each element
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
    
    func refreshToken() {
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
            self.login()
        }
    }
}

// MARK: - Helpers

extension Resource {
    
    //  Headers
    func headerResource(token: String) -> [String: String] {
        let headers = ["Accept": "application/json, application/x-www-form-urlencoded",
                       "Authorization" : "Bearer \(token)"]
        return headers
    }
    
    func headerRefreshToken(base64Encoded: String) -> [String: String] {
        let headers = ["Authorization"  : "Basic \(base64Encoded)",
                       "Content-Type"   : "text/html"]
        return headers
    }
    
    
    func paramsRefreshToken() -> [String: String] {
        let refreshToken = NSUserDefaults.standardUserDefaults().objectForKey("refresh_token") as! String
        let params = ["client_id"       : "CLI1455983911404GzJ5rZJOV2sH37vNncxsPvRAofHTff4MGzR6K02K84764Y",
                      "client_secret"   : "C4ligul4s",
                      "refresh_token"   : refreshToken,
                      "grant_type"      : "refresh_token"
        ]
        return params
    }
    
    
    func base64EncodedString() -> String {
        let clientID_ClientSecret = APIConstants.APIClientID()!+":"+APIConstants.APIClientSecret()!
        let authentification = clientID_ClientSecret.dataUsingEncoding(NSUTF8StringEncoding)
        let base64Encoded = authentification?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        return base64Encoded!
    }
    
    func updateCredentials(json: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(json["access_token"] as! String, forKey: "token")
        NSUserDefaults.standardUserDefaults().setObject(json["refresh_token"] as! String, forKey: "refresh_token")
        NSUserDefaults.standardUserDefaults().setObject(json["expires_in"] as! NSNumber, forKey: "expires_in")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
