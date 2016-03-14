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
    // Outlets whos informations will be fed into a dictionary
    @IBOutlet weak var student_number: UITextField!
    @IBOutlet weak var student_name: UITextField!
    @IBOutlet weak var student_department: UITextField!
    @IBOutlet weak var student_lecture: UITextField!
    @IBOutlet weak var left_handed: UISwitch!
    // The dictionary to be passed to sub_view_controller
    var passing_data = [String: String]()
    
    
    
    
    
    ///////////////////////// Actions /////////////////////////
    
    
    
    /////////////////////////
    // To sub_view_controller
    /////////////////////////
    
    //// From main_view_controller to sub_view_controller
    override func prepareForSegue(segue:UIStoryboardSegue, sender: AnyObject?) {
        // Setting destination as sub_view_controller
        let destination = segue.destinationViewController as! sub_view_controller
        // Stashing user input data to the dictionary
        destination.passing_data["student_number"] = student_number.text
        destination.passing_data["student_name"] = student_name.text
        destination.passing_data["student_department"] = student_department.text
        destination.passing_data["student_lecture"] = student_lecture.text
        destination.passing_data["left_button"] = String(left_handed.enabled)
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