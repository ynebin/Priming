//
//  sub_view_controller.swift
//  Priming
//
//  Created by KimWiback on 3/14/16.
//  Copyright © 2016 KimWiback. All rights reserved.
//






////////////////////////////// Sub //////////////////////////////
import UIKit
import Foundation
import SwiftCSV
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
    
    
    
    //////////
    // Stimuli
    //////////
    var same_semantic_prime:Array<String> = []
    var same_semantic_target:Array<String> = []
    var similar_phone_prime:Array<String> = []
    var similar_phone_target:Array<String> = []
    var diff_prime:Array<String> = []
    var diff_target:Array<String> = []
    var fixation:String = "+"
    
    
    
    //////////
    // Answers
    //////////
    var o_button_tf:Array<String> = []
    var x_button_tf:Array<String> = []
    
    
    
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
        
        //// Loading the stimuli
        do {
            // Reading input csv file from app bundle
            //            let bundle = NSBundle.mainBundle()
            //            let full_path = bundle.pathForResource("word_sets_ver2", ofType: "csv")
            // Using SwiftCSV
            let csv = try CSV(name: "/Users/KimWiback/Desktop/Priming/word_sets_ver2.csv")
            self.same_semantic_prime = csv.columns["same_semantic_prime"]!
            self.same_semantic_target = csv.columns["same_semantic_target"]!
            self.similar_phone_prime = csv.columns["similar_phone_prime"]!
            self.similar_phone_target = csv.columns["similar_phone_target"]!
            self.diff_prime = csv.columns["diff_prime"]!
            self.diff_target = csv.columns["diff_target"]!
            // Error handling
        } catch {
        }
    }
    
    
    
    
    
    
    ///////////////////////// Actions /////////////////////////
    
    
    
    ///////////////
    // Start button
    ///////////////
    @IBAction func start_button(sender: AnyObject) {
        
        
        
        ////////
        // Timer
        ////////
        // Start after...
        let start_interval = 0.0
        // Pause inbetween labels...
        let between_interval = 3.0
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
        
        //// Main loop
        for n in 0...self.same_semantic_prime.count - 1 {
            // Double type transition (type sensitive)
            let n = Double(n)
            
            //// Displaying
            delay(start_interval + (n - 1) * between_interval){() -> () in self.label_text.text = self.fixation
                self.start_button.hidden = true
                self.o_button.hidden = true
                self.x_button.hidden = true
                self.label_text.hidden = false}
            // Fixation 0.5 for every loop
            delay(start_interval + (n - 1) * between_interval + 0.5){() -> () in self.label_text.text = self.same_semantic_prime[Int(n)]} // Int type transition (type sensitive)
            // Giving 0.5 between prime & target
            delay(start_interval + (n - 1) * between_interval + 1){() -> () in self.label_text.text = self.same_semantic_target[Int(n)]}
            // User has 1.5 seconds to answer.
            delay(start_interval + (n - 1) * between_interval + 1.5){() -> () in
                self.o_button.hidden = false
                self.x_button.hidden = false
                self.label_text.hidden = true
                // Run tic - toc.
                self.start_time = NSDate.timeIntervalSinceReferenceDate()
                // When the user fail to answer in time, do minus pedding.
                self.x_button_tf.append(String(-1))
                self.o_button_tf.append(String(-1))
            }
        }
        
        
        
        
        
        
        
        
        
        
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
        // Saving RT
        let x_pressed_moment = NSDate.timeIntervalSinceReferenceDate()
        self.x_response_time = x_pressed_moment - self.start_time
        // Saving answers when pressed
        self.x_button_tf.append(String(self.x_button.enabled))
        // Preventing double click
        self.x_button.hidden = true
        self.o_button.hidden = true
        self.label_text.hidden = false
    }
    
    
    
    ///////////
    // O button
    ///////////
    @IBAction func o_button(sender: AnyObject) {
        // Saving RT
        let o_pressed_moment = NSDate.timeIntervalSinceReferenceDate()
        self.o_response_time = o_pressed_moment - self.start_time
        // Saving answers when pressed
        self.o_button_tf.append(String(self.o_button.enabled))
        // Preventing double click
        self.x_button.hidden = true
        self.o_button.hidden = true
        self.label_text.hidden = false
    }
    
    
    
    //////////////////////////////////////////////////
    // Dispose of any resources that can be recreated.
    //////////////////////////////////////////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}