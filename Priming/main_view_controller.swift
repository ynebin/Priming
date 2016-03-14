//
//  main_view_controller.swift
//  Priming
//
//  Created by KimWiback on 3/14/16.
//  Copyright © 2016 KimWiback. All rights reserved.
//





///////////////////////////// Main /////////////////////////////
import UIKit
class main_view_controller: UIViewController {
    
    
    
    
    
    ///////////////////////// Outlets /////////////////////////
    @IBOutlet weak var student_number: UITextField!
    @IBOutlet weak var student_name: UITextField!
    @IBOutlet weak var student_department: UITextField!
    @IBOutlet weak var student_lecture: UITextField!
    @IBOutlet weak var left_button: UISwitch!
    
    
    
    
    
    ///////////////////////// Actions /////////////////////////
    
    
    
    ////////////////////////
    // Start button callback
    ////////////////////////
    @IBAction func start_button(sender: AnyObject) {
        
        //// 1. Send a request to server (Mailgun).
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "https://api.mailgun.net/v3/sandbox15cbe9dbdda946eebdea18594ab7d313.mailgun.org/messages")!)
        
        // Set a type of communication between a client (user) and the server.
        request.HTTPMethod = "POST" // 'POST' request is used to send data to the server.
        
        //// 2. You have to authenticate (ID, Password) to the Mailgun to send mails through it.
        let username = "api"
        let password = "key-13bf8dc7873358d4352e591919b48616"
        // Making a login information string with the username and the password
        let loginString = NSString(format: "%@:%@", username, password)
        // Login information encodings
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions([])
        // Setting the request header field: authorization header field is used.
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        //// 3. Setting up data you want to send to the server
        // If the user filled out blanks, then proceed with those infomations.
        if let number_text = student_number.text, name_text = student_name.text, department_text = student_department.text, lecture_text = student_lecture.text {
            // to == receiver's name<email>
            // &subject == desired subject
            // Subject&text == body
            let bodyStr = "from=Mailgun Sandbox <postmaster@sandbox15cbe9dbdda946eebdea18594ab7d313.mailgun.org>&to=Hyebin Yoon <hbyoon28@gmail.com>&subject=Priming Subject&text=Student Number - \(number_text)\n Name - \(name_text)\n Department - \(department_text)\n Lecture - \(lecture_text)"
            // Appending the above data to the request body (do encoding here too.)
            request.HTTPBody = bodyStr.dataUsingEncoding(NSUTF8StringEncoding);
        }
        
        //// 4. Create task object to implement the request.
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            // When the server responses with an error, then print that error.
            if let error = error {
                print(error)
            }
            // When the server responses positively, print those too.
            if let response = response {
                print("url = \(response.URL!)")
                print("response = \(response)")
                let httpResponse = response as! NSHTTPURLResponse
                print("response code = \(httpResponse.statusCode)")
            }
        })
        
        //// 5. Finally, execute the task object.
        task.resume()
    }
    
    
    
    //////////////////////////////
    // Left-handed button callback
    //////////////////////////////
    @IBAction func left_button(sender: AnyObject) {
    }
    
    
    
    //////////////////////////////////////////////////
    // Do any additional setup after loading the view.
    //////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    //////////////////////////////////////////////////
    // Dispose of any resources that can be recreated.
    //////////////////////////////////////////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}