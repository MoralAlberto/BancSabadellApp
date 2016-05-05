//
//  BancSabadellManager.swift
//  Boomerang
//
//  Created by Alberto Moral on 26/2/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import OAuthSwift

class BancSabadellManager {
    
    static let oauthswift = OAuth2Swift(
        consumerKey:    "CLI1455983911404GzJ5rZJOV2sH37vNncxsPvRAofHTff4MGzR6K02K84764Y",
        consumerSecret: "C4ligul4s",
        authorizeUrl:   "https://developers.bancsabadell.com/AuthServerBS/oauth/authorize",
        accessTokenUrl: "https://developers.bancsabadell.com/AuthServerBS/oauth/token",
        responseType:   "code"
    )
    
    class func login() {
        let token = NSUserDefaults.standardUserDefaults().stringForKey("bancSabadellToken")
        
//        if ((token == nil)) {
        
            let oauthswift = OAuth2Swift(
                consumerKey:    "CLI1455983911404GzJ5rZJOV2sH37vNncxsPvRAofHTff4MGzR6K02K84764Y",
                consumerSecret: "C4ligul4s",
                authorizeUrl:   "https://developers.bancsabadell.com/AuthServerBS/oauth/authorize",
                accessTokenUrl: "https://developers.bancsabadell.com/AuthServerBS/oauth/token",
                responseType:   "code"
            )
            
            oauthswift.accessTokenBasicAuthentification = true
            
            let state: String = generateStateWithLength(16) as String
            
            oauthswift.authorizeWithCallbackURL(
                NSURL(string: "BancApp://oauth-callback")!,
                scope: "read+auth", state: state,
                success: { credential, response, parameters in
                    print("Token: \(credential.oauth_token) \n")
                    print("Refresh Token: \(credential.oauth_refresh_token) \n")
                    print("Expires at: \(credential.oauth_token_expires_at) \n")
                    
                    NSUserDefaults.standardUserDefaults().setObject(credential.oauth_token, forKey: "bancSabadellToken")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                },
                failure: { error in
                    print(error.localizedDescription)
                }
            )
        
//        }
    }
    
//    class func cuentasVista() {
//        
//        let token = NSUserDefaults.standardUserDefaults().objectForKey("bancSabadellToken")
//        
//        if (token != nil) {
//            let headers = ["Accept": "application/json, application/x-www-form-urlencoded",
//                "Authorization" : "Bearer \(token! as! String)"]
//            
//            Alamofire.request(.POST, "https://developers.bancsabadell.com/ResourcesServerBS/oauthservices/v1.0.0/cuentasvista", parameters: nil, encoding: ParameterEncoding.JSON, headers: headers)
//                .responseJSON { response in
//                    print(response.result)   // result of response serialization
//                    
//                    let parsedObject: AnyObject?
//                    do {
//                        parsedObject = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions())
//                        
//                        print("Parsed Object \(parsedObject)")
//                        
//                        
//                        
//                        
//                    } catch _ as NSError {
//                        parsedObject = nil
//                    }
//            }
//        }
//    }
}

//0081 000000000000000 1