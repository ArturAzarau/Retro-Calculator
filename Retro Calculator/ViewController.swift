//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Artur Azarov on 18.02.17.
//  Copyright © 2017 Artur Azarov. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var resultLbl: UILabel!
    var btnSound : AVAudioPlayer!
    var runningNumber = ""
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    var currentOperation = Operation.Empty
    var leftVal = ""
    var rightVal = ""
    var result = ""
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
    let path = Bundle.main.path(forResource: "btn", ofType: "wav")
    let soundURL = URL(fileURLWithPath: path!)
    
    do {
        try
        btnSound = AVAudioPlayer(contentsOf: soundURL)
        btnSound.prepareToPlay()
    } catch let err as NSError {
        print(err.debugDescription)
    }
    
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        resultLbl.text = runningNumber
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation (operation: Operation) {
        if currentOperation != Operation.Empty {
            if !runningNumber.isEmpty {
                rightVal = runningNumber
                runningNumber = ""
                switch currentOperation {
                case .Divide:
                    result = "\(Double(leftVal)! / Double(rightVal)!)"
                case .Multiply:
                    result = "\(Double(leftVal)! * Double(rightVal)!)"
                case .Add:
                    result = "\(Double(leftVal)! + Double(rightVal)!)"
                case .Subtract:
                    result = "\(Double(leftVal)! - Double(rightVal)!)"
                default:
                    break
                }
                leftVal = result
                resultLbl.text = result
            }
                currentOperation = operation
            
        }
        
        else {
            leftVal = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    @IBAction func dividePressed(sender: UIButton) {
        playSound()
        processOperation(operation: .Divide)
    }
    @IBAction func multiplyPressed(sender: UIButton) {
        playSound()
        processOperation(operation: .Multiply)
    }
    @IBAction func addPressed(sender: UIButton) {
        playSound()
        processOperation(operation: .Add)
    }
    @IBAction func subtractPressed(sender: UIButton) {
        playSound()
        processOperation(operation: .Subtract)
    }
    @IBAction func equalPressed(sender: UIButton) {
        playSound()
        processOperation(operation: currentOperation)
    }
    @IBAction func acPressed (sender: UIButton) {
        playSound()
        runningNumber = ""
        currentOperation = Operation.Empty
        leftVal = ""
        rightVal = ""
        result = ""
        resultLbl.text = "0"
    }
}

