//
//  Datalayer.swift
//  Meat Meister
//
//  Created by Deenadayal Loganathan on 2/9/16.
//  Copyright © 2016 Deena. All rights reserved.
//

import Foundation

class Data {
    
   class func getData(URL:String,success: ((appData: NSData!) -> Void)) {
        //1
        loadDataFromURL(NSURL(string: URL)!, completion:{(data, error) -> Void in
            //2
            if let urlData = data {
                //3
                success(appData: urlData)
            }
        })
    }
    
  class  func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"com.raywenderlich", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        
        /* let loadDataTask = session.dataTaskWithURL(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        
        if let responseError = error {
        completion(data: nil, error: responseError)
        } else if let httpResponse = response as? NSHTTPURLResponse {
        if httpResponse.statusCode != 200 {
        let statusError = NSError(domain:"com.raywenderlich", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
        completion(data: nil, error: statusError)
        } else {
        completion(data: data, error: nil)
        }
        }
        })*/
        //loadDataTask.set
        //  loadDataTask.setValue("application/json", forHTTPHeaderField:"Content-Type" )
        
        loadDataTask.resume()
    }
    
    
}