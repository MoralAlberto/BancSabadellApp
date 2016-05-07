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
        consumerKey:    "CLI1455983911404GzJ5rZJOV2sH37vNncxsPvRAofHTff4MGzR6K02K84764Y",
        consumerSecret: "C4ligul4s",
        authorizeUrl:   "https://developers.bancsabadell.com/AuthServerBS/oauth/authorize",
        accessTokenUrl: "https://developers.bancsabadell.com/AuthServerBS/oauth/token",
        responseType:   "code"
    )
    
    let credential = OAuthSwiftCredential(consumer_key: "CLI1455983911404GzJ5rZJOV2sH37vNncxsPvRAofHTff4MGzR6K02K84764Y", consumer_secret: "C4ligul4s")
}

extension Resource {
    func loadAsynchronous<A: Mappable>(toClass: A.Type, callback: A -> ())  {
        
        //  Si existe el token, haz la llamada a la API
        if let token = NSUserDefaults.standardUserDefaults().objectForKey("token") {
            
            let headers = ["Accept": "application/json, application/x-www-form-urlencoded",
                           "Authorization" : "Bearer \(token)"]
            
            oauthswift.startAuthorizedRequest(pathComponent, method: .POST, parameters: [:], headers: headers, success: { (data, response) in
                
                
                    let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
                    let result = Mapper<A>().map(json)
                    callback(result!)
                    
                    print("JSON \(json) and data \(data)")
                

            }) { (error) in
                print(error)
                //  Si hay error, haz la lógica para refrescar el Token
                self.refreshToken()
            }
        
        //  Si no existe el token, carga la web para logearme
        } else {
            login()
        }

    }
    
    
    func login() {
        oauthswift.accessTokenBasicAuthentification = true
        
        let state: String = generateStateWithLength(16) as String
        
        oauthswift.authorizeWithCallbackURL(
            NSURL(string: "BancApp://oauth-callback")!,
            scope: "read+auth", state: state,
            success: { credential, response, parameters in
                print("Token: \(credential.oauth_token) \n")
                print("Refresh Token: \(credential.oauth_refresh_token) \n")
                print("Expires at: \(credential.oauth_token_expires_at) \n")
                
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
        let refreshToken = NSUserDefaults.standardUserDefaults().objectForKey("refresh_token") as! String

        let authentification = "CLI1455983911404GzJ5rZJOV2sH37vNncxsPvRAofHTff4MGzR6K02K84764Y:C4ligul4s".dataUsingEncoding(NSUTF8StringEncoding)
        let base64Encoded = authentification?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
 
        let headers = ["Authorization"  : "Basic \(base64Encoded!)",
                       "Content-Type"   : "text/html"]
 
        let params = ["client_id"       : "CLI1455983911404GzJ5rZJOV2sH37vNncxsPvRAofHTff4MGzR6K02K84764Y",
                      "client_secret"   : "C4ligul4s",
                      "refresh_token"   : refreshToken,
                      "grant_type"      : "refresh_token"
                      ]
        
        oauthswift.startAuthorizedRequest("https://developers.bancsabadell.com/AuthServerBS/oauth/token", method: .POST, parameters: params, headers: headers, success: { (data, response) in
            
            let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
            print("JSON \(json) and data \(data)")
            
            // each element
            NSUserDefaults.standardUserDefaults().setObject(json!["access_token"] as! String, forKey: "token")
            NSUserDefaults.standardUserDefaults().setObject(json!["refresh_token"] as! String, forKey: "refresh_token")
            NSUserDefaults.standardUserDefaults().setObject(json!["expires_in"] as! NSNumber, forKey: "expires_in")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }) { (error) in
            print(error)
            self.login()
        }
    }
}
