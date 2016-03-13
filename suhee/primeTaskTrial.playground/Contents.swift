//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
//
//  ViewController.swift
//  primeTxt
//
//  Created by JoSuhee on 3/10/16.
//  Copyright © 2016 KoreaUniversity. All rights reserved.
//

import UIKit
import Foundation

class TrialSet1View: UIViewController {
    
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var trueButton: UIButton!
    
    @IBOutlet weak var falseButton: UIButton!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    // set startTime as 0. Later on, this value will be changed.
    // startTime will be reset when the trial set is completed and it shows quesionLabel
    
    var startTime:NSTimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Till the wordLabel reaches the end, true Button, falseButton and questionLabel should remain unseen
        
        trueButton.hidden = true
        falseButton.hidden = true
        questionLabel.hidden = true
        
        // Below two lines enable multilines for the questionLabel
        questionLabel.lineBreakMode = .ByWordWrapping
        questionLabel.numberOfLines = 0
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startExp(sender: AnyObject) {
        
        //hide startButton
        
        self.startButton.hidden = true
        
        
        //set time interval values
        let startingInterval = 0.5
        let btwInterval = 0.7
        
        //this function let the closure ( the seconde argument of the funcion) be executed after delay ( the first argument) from the time this function is run
        func delay(delay:Double, closure:()->()) {
            dispatch_after(
                dispatch_time(
                    DISPATCH_TIME_NOW,
                    Int64(delay * Double(NSEC_PER_SEC))
                ),
                dispatch_get_main_queue(), closure)
        }
        
        
        /*
        //first, set the fixation point, which is +, as a default for wordLabel
        
        
        
        delay(0){() -> () in self.wordLabel.text = wordListSet1[0]}
        
        
        delay(startingInterval){() -> () in self.wordLabel.text = wordListSet1[1]}
        
        delay(startingInterval+1*btwInterval){() -> () in self.wordLabel.text = wordListSet1[2]}
        delay(startingInterval+2*btwInterval){() -> () in self.wordLabel.text = wordListSet1[3]}
        
        delay(startingInterval+3*btwInterval){() -> () in self.wordLabel.text = wordListSet1[4]}
        
        delay(startingInterval+4*btwInterval){() -> () in
        self.trueButton.hidden = false
        self.falseButton.hidden = false
        self.questionLabel.hidden = false
        }
        
        delay(startingInterval+(4+1)*btwInterval){() -> () in
        
        }
        
        
        
        
        for i in 0...summedList.count-1
        {   let times = Double(i)
        delay(startingInterval+times * btwInterval){() -> () in self.wordLabel.text = wordListSet1[i]}
        
        
        }
        
        
        for i in 0...summedList.count-1 {
        // each trial set in summedList has equal numbers of trial
        let numOfWordsInTrial = summedList[0].count
        
        for m in 0...numOfWordsInTrial-1 {
        
        let times = Double(m)
        
        delay(startingInterval+(Double(numOfWordsInTrial)*Double(i)+times )* btwInterval){() -> () in self.wordLabel.text = summedList[i][m]}
        
        }
        var setEndTime = Double(summedList[i].count)
        
        }
        */
        
        //designate a trial set for this view controller
        
        
        
        let trialSet1:Array<String> = summedList[0] // which is 5
        
        // wordListSet1[0] is "+". fixation point
        
        delay(0){() -> () in self.wordLabel.text = wordListSet1[0]}
        
        // m goes from 1 to 4
        for m in 1...trialSet1.count-1 {
            
            let times = Double(m)
            
            delay(startingInterval+(times-1)*btwInterval){() -> () in self.wordLabel.text = trialSet1[m]}
        }
        
        delay(startingInterval+4*btwInterval){() -> () in
            self.trueButton.hidden = false
            self.falseButton.hidden = false
            self.questionLabel.hidden = false
            self.startTime = NSDate.timeIntervalSinceReferenceDate()
        }
        
        
        
        
    }
    
    
    var reactionTimeForTrue:NSTimeInterval = 0
    var reactionTimeForFalse:NSTimeInterval = 0
    
    
    @IBAction func pressTrue(sender: AnyObject) {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        let elapsedTime: NSTimeInterval = currentTime - startTime
        
        self.reactionTimeForTrue = elapsedTime
        
    }
    
    
    
    @IBAction func pressFalse(sender: AnyObject) {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        let elapsedTime: NSTimeInterval = currentTime - startTime
        
        self.reactionTimeForFalse = elapsedTime
        
        
    }
    
    
}