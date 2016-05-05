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

struct Resource<A> {
    let pathComponent: String
}

extension Resource {
    func loadAsynchronous<A: Mappable>(toClass: A.Type, callback: A -> ())  {
        let session = NSURLSession.sharedSession()
        
        let token = NSUserDefaults.standardUserDefaults().objectForKey("bancSabadellToken")
        let headers = ["Accept": "application/json, application/x-www-form-urlencoded",
                       "Authorization" : "Bearer \(token! as! String)"]
        
        let request = NSMutableURLRequest(URL: NSURL(string: pathComponent)!)
        request.HTTPMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        session.dataTaskWithRequest(request) { data, response, error in
            let json = data.flatMap {
                try? NSJSONSerialization.JSONObjectWithData($0, options: NSJSONReadingOptions())
            }
            
            let result = Mapper<A>().map(json)
            callback(result!)
            
        }.resume()
    }
    
//    func loginOrRefreshToken() {
//        //  Check if has token and if the token is valid
//        //  if there is NO token
//        
//        let token = NSUserDefaults.standardUserDefaults().stringForKey("bancSabadellToken")
//        
//        let oauthswift = OAuth2Swift(
//            consumerKey:    "CLI1455983911404GzJ5rZJOV2sH37vNncxsPvRAofHTff4MGzR6K02K84764Y",
//            consumerSecret: "C4ligul4s",
//            authorizeUrl:   "https://developers.bancsabadell.com/AuthServerBS/oauth/authorize",
//            accessTokenUrl: "https://developers.bancsabadell.com/AuthServerBS/oauth/token",
//            responseType:   "code"
//        )
//        
//        oauthswift.accessTokenBasicAuthentification = true
//        
//        let state: String = generateStateWithLength(16) as String
//        
//        oauthswift.authorizeWithCallbackURL(
//            NSURL(string: "BancApp://oauth-callback")!,
//            scope: "read+auth", state: state,
//            success: { credential, response, parameters in
//                print("Token: \(credential.oauth_token) \n")
//                print("Refresh Token: \(credential.oauth_refresh_token) \n")
//                print("Expires at: \(credential.oauth_token_expires_at) \n")
//                
//                NSUserDefaults.standardUserDefaults().setObject(credential.oauth_token, forKey: "bancSabadellToken")
//                NSUserDefaults.standardUserDefaults().synchronize()
//                
//            },
//            failure: { error in
//                print(error.localizedDescription)
//            }
//        )
//        
//        //  If there is a expired token call a new API call
//    }
    
    func refreshToken() {
        //let refreshToken = NSUserDefaults.standardUserDefaults().objectForKey("bancSabadellToken")
        let token = "8b00f6b9-64b7-4d9b-a4e6-9635f45118f3b31f891a-4e53-4db4-996d-8a53e53eec0253e68eab-07c9-415b-9734-51c6c223ce2c"
        let refreshToken = "14a5cbef-b12d-4d24-8f84-d6dd6cc75d5f"
        
        
        let authentification = "CLI1455983911404GzJ5rZJOV2sH37vNncxsPvRAofHTff4MGzR6K02K84764Y:C4ligul4s".dataUsingEncoding(NSUTF8StringEncoding)
        let base64Encoded = authentification?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
//        {
//            headers = ["Authorization": "Basic \(base64Encoded)"]
//        }
        
        
        
        let headers = ["Accept": "application/json, application/x-www-form-urlencoded",
                       "Authorization" : "Basic \(base64Encoded!)"]
        
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://developers.bancsabadell.com/AuthServerBS/oauth/token")!)
        request.HTTPMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        
        let params = ["client_id":"CLI1455983911404GzJ5rZJOV2sH37vNncxsPvRAofHTff4MGzR6K02K84764Y", "client_secret":"C4ligul4s", "grant_type":"refresh_token", "refresh_token":refreshToken]
        
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.PrettyPrinted)
        
        
        session.dataTaskWithRequest(request) { data, response, error in
            let json = data.flatMap {
                try? NSJSONSerialization.JSONObjectWithData($0, options: NSJSONReadingOptions())
            }
            
            print("Datos recibidos \(json)")
            
            
        }.resume()
        
    }

}
