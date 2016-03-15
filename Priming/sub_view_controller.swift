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
    
    
    
    
    
    ///////////////////////// Settings /////////////////////////
    
    
    
    //////////
    // Outlets
    //////////
    @IBOutlet weak var label_text: UILabel!
    @IBOutlet weak var x_button: UIButton!
    @IBOutlet weak var o_button: UIButton!
    @IBOutlet weak var start_button: UIButton!
    
    
    
    /////////////////////
    // Parameter settings
    /////////////////////
    
    //// The dictionary came from main_view_controller
    var passing_data = [String: String]()
    // Variables will capture informations from the dictionary
    var student_number:String?
    var student_name:String?
    var student_department:String?
    var student_lecture:String?
    var left_button:String?
    
    //// Tic - Toc
    // Tic
    var start_time:NSTimeInterval = 0
    // Toc
    var x_response_time:NSTimeInterval = 0
    var o_response_time:NSTimeInterval = 0
    
    
    
    /////////
    // Inputs
    /////////
    
    
    
    
    
    ///////////////////////// Actions /////////////////////////
    
    
    
    ///////////////
    // Start button
    ///////////////
    @IBAction func start_button(sender: AnyObject) {
        
        //// Hiding on start
        // Outlets can be referenced without self instance.
        start_button.hidden = true
        o_button.hidden = true
        x_button.hidden = true
        
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
        
        
        
        
        
        
        
        
        ////////
        // Timer
        ////////
        // Start after...
        let startingInterval = 0.5
        // Pause inbetween labels...
        let btwInterval = 0.7
        
        // This function executes a closure (second argument) after some delay (first argument).
        func delay(delay:Double, closure:()->()) {
            dispatch_after(
                dispatch_time(
                    DISPATCH_TIME_NOW,
                    Int64(delay * Double(NSEC_PER_SEC))
                ),
                dispatch_get_main_queue(), closure)
        }
        
        
        
        ////////////////////
        // Main priming task
        ////////////////////
        
        // Run tic - toc.
        self.start_time = NSDate.timeIntervalSinceReferenceDate()
        
        //        let trialSet1:Array<String> = summedList[0] // which is 5
        //
        //        // wordListSet1[0] is "+". fixation point
        //
        //        delay(0){() -> () in self.wordLabel.text = wordListSet1[0]}
        //
        //        // m goes from 1 to 4
        //        for m in 1...trialSet1.count-1 {
        //
        //            let times = Double(m)
        //
        //            delay(startingInterval+(times-1)*btwInterval){() -> () in self.wordLabel.text = trialSet1[m]}
        //        }
        //
        //        delay(startingInterval+4*btwInterval){() -> () in
        //            self.trueButton.hidden = false
        //            self.falseButton.hidden = false
        //            self.questionLabel.hidden = false
        //            self.startTime = NSDate.timeIntervalSinceReferenceDate()
        //        }
        //
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    ///////////
    // X button
    ///////////
    @IBAction func x_button(sender: AnyObject) {
        // Saving RT
        let x_pressed_moment = NSDate.timeIntervalSinceReferenceDate()
        self.x_response_time = x_pressed_moment - start_time
    }
    
    
    
    ///////////
    // O button
    ///////////
    @IBAction func o_button(sender: AnyObject) {
        // Saving RT
        let o_pressed_moment = NSDate.timeIntervalSinceReferenceDate()
        self.o_response_time = o_pressed_moment - start_time
    }
    
    
    
    //////////////////////////////////////////////////
    // Do any additional setup after loading the view.
    //////////////////////////////////////////////////
    override func viewDidLoad() {
        
        //// From main_view_controller
        super.viewDidLoad()
        // Re-distributing informations (heuristic indexing)
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