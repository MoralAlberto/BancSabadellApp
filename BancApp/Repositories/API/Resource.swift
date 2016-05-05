//
//  Resource.swift
//  DemoStackOverflow
//
//  Created by Alberto Moral on 30/4/16.
//  Copyright © 2016 Alberto Moral. All rights reserved.
//

import Foundation
import ObjectMapper

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
}
