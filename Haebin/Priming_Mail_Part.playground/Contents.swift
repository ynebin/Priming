//
//  ViewController.swift
//  Priming
//
//  Created by KimWiback on 3/9/16.
//  Copyright © 2016 KimWiback. All rights reserved.


import UIKit

class ViewController: UIViewController {
    
    //////////
    // Outlets
    //////////
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var department: UITextField!
    @IBOutlet weak var lecture: UITextField!
    
    /////////////////
    // Given defaults
    /////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // If a subject writes his/her information, and then click the Start button
    // this function will send email about subject's input information
    // via 'Mailgun'(API) which provides email-sending-and-receiving services.
    @IBAction func taskStarted(sender: AnyObject) {
        
        // Send a request to the server in order to access to the site (Mailgun)
        // In order to use Mailgun, you need to sign up for an account.
        
        // 1. REQUEST LINE
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "https://api.mailgun.net/v3/sandbox15cbe9dbdda946eebdea18594ab7d313.mailgun.org/messages")!)
        
        // Set the type of communication between a client(who sends a request) and the server
        request.HTTPMethod = "POST"
        // In this case, type 'POST' is used
        // A POST request is used to send data to the server
        // for example, customer information, file upload, etc.
        
        
        // 2. HEADER
        // Basic Authentication
        // You have to authenticate to the Mailgun to send mails through it.
        let username = "api"
        let password = "key-13bf8dc7873358d4352e591919b48616"
        // 'password' is a unique API key given to each mailgun users.
        // Authenticate to the mailgun API by providing your own API key in the request.
        
        // Make a login information string with username and password
        let loginString = NSString(format: "%@:%@", username, password)
        
        // Convert login information string to data (in order to change loginString into Base-64 encoded string)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        
        // Convert login data to Base-64 encoded string
        let base64LoginString = loginData.base64EncodedStringWithOptions([])
        
        // Set the request header field
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        // In this case, Authorization header field was set
        // Authorization header field is used when the user agent wishes to authenticate to the server
        // Authorization header field consists of credentials containing the authentication information of the user agent (username and password(API key) in this case)
        
        
        //3. BODY
        // Set the data you want to send to the server
        // In this case, the data consists of the sender, receiver, and the contents of email you want to send through Mailgun
        if let number_t = number.text, name_t = name.text, department_t = department.text, lecture_t = lecture.text {
            let bodyStr = "from=Mailgun Sandbox <postmaster@sandbox15cbe9dbdda946eebdea18594ab7d313.mailgun.org>&to=Hyebin Yoon <hbyoon28@gmail.com>&subject=Priming Subject&text=Student Number - \(number_t)\n Name - \(name_t)\n Department - \(department_t)\n Lecture - \(lecture_t)"
            // input information(student number, name, department, lecture name) is included in the mail
            
            
            // Append the data to the request body
            request.HTTPBody = bodyStr.dataUsingEncoding(NSUTF8StringEncoding);
        }
        
        // Create data task to implement a request
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            
            // RESPONSE FROM SERVER
            if let error = error {
                print(error)
            }
            // The server sends a response message
            if let response = response {
                print("url = \(response.URL!)")
                print("response = \(response)")
                let httpResponse = response as! NSHTTPURLResponse
                print("response code = \(httpResponse.statusCode)")
            }
            
            
        })
        // Execute the task
        task.resume()
    }
    
}

