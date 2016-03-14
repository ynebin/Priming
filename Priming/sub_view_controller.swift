//
//  sub_view_controller.swift
//  Priming
//
//  Created by KimWiback on 3/14/16.
//  Copyright © 2016 KimWiback. All rights reserved.
//





////////////////////////////// Sub //////////////////////////////
import UIKit
class sub_view_controller: UIViewController {
    
    
    
    
    
    ///////////////////////// Outlets /////////////////////////
    @IBOutlet weak var label_text: UILabel!
    @IBOutlet weak var x_button: UIButton!
    @IBOutlet weak var o_button: UIButton!
    @IBOutlet weak var start_button: UIButton!
    
    //// The dictionary came from main_view_controller
    var passing_data = [String: String]()
    // Variables will capture informations from the dictionary
    var student_number:String?
    var student_name:String?
    var student_department:String?
    var student_lecture:String?
    var left_button:String?
    
    
    
    
    
    ///////////////////////// Actions /////////////////////////
    
    
    
    ///////////////
    // Start button
    ///////////////
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
        if let number_text = self.student_number, name_text = self.student_name, department_text = self.student_department, lecture_text = self.student_lecture {
            // to == receiver's name<email>
            // &subject == desired subject
            // &text == body
            let bodyStr = "from=Mailgun Sandbox <postmaster@sandbox15cbe9dbdda946eebdea18594ab7d313.mailgun.org>&to=EMCS <koreamatlab@gmail.com>&subject=Priming: \(name_text)&text=Name: \(name_text)\nStudent Number: \(number_text)\n Department: \(department_text)\n Lecture: \(lecture_text)"
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
    
    
    
    ///////////
    // X button
    ///////////
    @IBAction func x_button(sender: AnyObject) {
    }
    
    
    
    ///////////
    // O button
    ///////////
    @IBAction func o_button(sender: AnyObject) {
    }
    
    
    
    //////////////////////////////////////////////////
    // Do any additional setup after loading the view.
    //////////////////////////////////////////////////
    override func viewDidLoad() {
        
        //// From main_view_controller
        super.viewDidLoad()
        // Distributing informations (heuristic indexing)
        self.student_number = [String](passing_data.values)[1]
        self.student_name = [String](passing_data.values)[4]
        self.student_department = [String](passing_data.values)[3]
        self.student_lecture = [String](passing_data.values)[2]
        self.left_button = [String](passing_data.values)[0]
    }
    
    
    
    //////////////////////////////////////////////////
    // Dispose of any resources that can be recreated.
    //////////////////////////////////////////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}