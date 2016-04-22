//
//  myHTTPPost.swift
//  Bacon
//
//  Created by Jari Sandström on 21/04/16.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation


class myHTTPPost {
    
    var addEvent = AddEventController()
    
    var urlString = "http://172.20.10.2:8080/iBaconBackend/webresources/"
    
    func postData(data: String, urlExtension: String) {
        
        print("postDatan sisällä")
        let finalURL = urlString + urlExtension
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig);
        let request = NSMutableURLRequest()
        request.HTTPMethod = "POST"
        request.URL = NSURL(string: finalURL)
        request.addValue("application/xml", forHTTPHeaderField: "Content-Type")
        request.addValue("application/xml", forHTTPHeaderField: "Accept")
        
        let body = data
        
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        let sessionTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            print("posting done, response = \(response), error = \(error)")
        })
        sessionTask.resume()
    }

}