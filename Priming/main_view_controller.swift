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
    
    
    
    //////////
    // Outlets
    //////////
    @IBOutlet weak var student_number: UITextField!
    @IBOutlet weak var student_name: UITextField!
    @IBOutlet weak var student_department: UITextField!
    @IBOutlet weak var student_lecture: UITextField!
    @IBOutlet weak var left_button: UISwitch!
    
    
    
    //////////
    // Actions
    //////////
    @IBAction func start_button(sender: AnyObject) {
    }
    @IBAction func left_button(sender: AnyObject) {
    }
    
    //// Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //// Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}