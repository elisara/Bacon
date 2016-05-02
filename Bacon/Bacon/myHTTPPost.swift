import Foundation
import CoreData


class myHTTPPost {
    
    var addEvent = AddEventController()
    var eventparser = EventParser()
    var myget = MyHTTPGet()
    var urlString = "http://localhost:8080/iBaconBackend/webresources/"

    
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
            
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Datastring: ",dataString)
            self.eventparser.parse(data!)
            print(self.eventparser.currentString)
            
            })
        sessionTask.resume()
        
    }
    
}