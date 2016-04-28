//
//  MyHTTPGet.swift
//  Bacon
//
//  Created by Jari Sandström on 22/04/16.
//  Copyright © 2016 iosdev. All rights reserved.
//

import Foundation
import UIKit

class MyHTTPGet  {
    
    
    func httpGet(urlExtension: String) {
        print("GET")
        let urlString = "http://localhost:8080/iBaconBackend/webresources/"
        let finalURL = urlString + urlExtension
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig);
        let appDelegate     = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let sessionTask = session.dataTaskWithURL(NSURL(string: finalURL)!, completionHandler: { (data, response, error) -> Void in
            
            switch urlExtension{
            case "Event":
                //Define the operation we'd like to run in the operation queue
                let eventParseOperation = NSBlockOperation(block: {
                    print("Event block op runs")
                    let parser = EventParser()
                    parser.parse(data!)
                    //self.showTF.text = resultString
                })
                // create a queue and add the operation
                var queue: NSOperationQueue?
                queue = appDelegate.opQueue
                queue!.maxConcurrentOperationCount=1
                queue!.addOperation(eventParseOperation)
            case "Checkpoint":
                //Define the operation we'd like to run in the operation queue
                let checkpointParseOperation = NSBlockOperation(block: {
                    print("Checkpoint block op runs")
                    let parser = CheckpointParser()
                    parser.parse(data!)
                    //self.showTF.text = resultString
                })
                // create a queue and add the operation
                var queue: NSOperationQueue?
                queue = appDelegate.opQueue
                queue!.maxConcurrentOperationCount=1
                queue!.addOperation(checkpointParseOperation)
            case "User":
                //Define the operation we'd like to run in the operation queue
                let userParseOperation = NSBlockOperation(block: {
                    print("User block op runs")
                    let parser = UserParser()
                    parser.parse(data!)
                    //self.showTF.text = resultString
                })
                // create a queue and add the operation
                var queue: NSOperationQueue?
                queue = appDelegate.opQueue
                queue!.maxConcurrentOperationCount=1
                queue!.addOperation(userParseOperation)
            case "Score":
                //Define the operation we'd like to run in the operation queue
                let scoreParseOperation = NSBlockOperation(block: {
                    print("Score block op runs")
                    let parser = ScoreParser()
                    parser.parse(data!)
                    //self.showTF.text = resultString
                })
                // create a queue and add the operation
                var queue: NSOperationQueue?
                queue = appDelegate.opQueue
                queue!.maxConcurrentOperationCount=1
                queue!.addOperation(scoreParseOperation)
            default:
                break
            }
        })
        
        //.resume will cause the session task to execute
        sessionTask.resume()
        
    }
}

