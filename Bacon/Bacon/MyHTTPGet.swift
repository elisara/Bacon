//
//  MyHTTPGet.swift
//  Bacon
//
//  Created by Jari Sandström on 22/04/16.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation

class MyHTTPGet  {

    
    func httpGet(urlExtension: String) {
        
        let urlString = "http://localhost:8080/iBaconBackend/webresources/"
        let finalURL = urlString + urlExtension
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig);
        
        let sessionTask = session.dataTaskWithURL(NSURL(string: finalURL)!, completionHandler: { (data, response, error) -> Void in
            
            //Define the operation we'd like to run in the operation queue
            let studentParseOperation = NSBlockOperation(block: {
                print("block op runs")
                let parser = EventParser()
                parser.parse(data!)
                //self.showTF.text = resultString
            })
            // create a queue and add the operation
            let queue = NSOperationQueue()
            queue.maxConcurrentOperationCount=1
            queue.addOperation(studentParseOperation)
        })
        
        //.resume will cause the session task to execute
        sessionTask.resume()
        
    }


}