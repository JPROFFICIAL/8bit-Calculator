//
//  ViewController.swift
//  retroCalcul8r
//
//  Created by Jordan Olson on 10/8/15.
//  Copyright © 2015 JPRODUCTION. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    var buttonSound: AVAudioPlayer!
    
    var leftString = ""
    var rightString = ""
    var runningNumber = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sound player start code
        let path = NSBundle.mainBundle().pathForResource("Tick", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        //sound player end code
        
    }
    
    @IBAction func numberPressed(Btn: UIButton!) {
        playSound()
        runningNumber += "\(Btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func Multiply(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func Divide(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func Add(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func Subtract(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func Equals(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func Clear(sender: AnyObject) {
        leftString = ""
        rightString = ""
        runningNumber = ""
        currentOperation = Operation.Empty
        outputLbl.text = ""
        playSound()
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
        
            if runningNumber != "" {
                rightString = runningNumber
                runningNumber = ""
            
            if currentOperation == Operation.Multiply {
                result = "\(Double(rightString)! * Double(leftString)!)"
            } else if currentOperation == Operation.Divide {
                result = "\(Double(rightString)! / Double(leftString)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Double(rightString)! + Double(leftString)!)"
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(rightString)! - Double(leftString)!)"
            }
            
            leftString = result
           outputLbl.text = result
            }
            currentOperation = op

    } else {
    
            leftString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        buttonSound.play()
        
    }

}

