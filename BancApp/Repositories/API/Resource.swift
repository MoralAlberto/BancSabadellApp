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
        
        let headers = ["Accept": "application/json, application/x-www-form-urlencoded",
                       "Authorization" : "Bearer \(oauthswift.client.credential.oauth_token)"]
        
        oauthswift.client.credential = credential
        
        oauthswift.startAuthorizedRequest(pathComponent, method: .POST, parameters: [:], headers: headers, success: { (data, response) in
            
            let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
            
            let result = Mapper<A>().map(json)
            callback(result!)
            
            print("JSON \(json) and data \(data)")
        }) { (error) in
            print(error)
        }

        
//        let session = NSURLSession.sharedSession()
//        
//        let token = NSUserDefaults.standardUserDefaults().objectForKey("bancSabadellToken")
//        let headers = ["Accept": "application/json, application/x-www-form-urlencoded",
//                       "Authorization" : "Bearer \(token! as! String)"]
//        
//        let request = NSMutableURLRequest(URL: NSURL(string: pathComponent)!)
//        request.HTTPMethod = "POST"
//        request.allHTTPHeaderFields = headers
//        
//        session.dataTaskWithRequest(request) { data, response, error in
//            let json = data.flatMap {
//                try? NSJSONSerialization.JSONObjectWithData($0, options: NSJSONReadingOptions())
//            }
//            
//            let result = Mapper<A>().map(json)
//            callback(result!)
//            
//        }.resume()
    }
    
    
    func refreshToken() {
        let refreshToken = "d484f194-2a50-4bb0-aeca-9a11d1916a09"

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
            }) { (error) in
                print(error)
        }
    }

}
