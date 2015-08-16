//
//  ViewController.swift
//  calC+
//
//  Created by Riyaz Ahamed on 13/04/15.
//  Copyright (c) 2015 iAppTest Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var brain = CalculatorBrain()
    
    @IBOutlet weak var display: UILabel!
    
    var userIsIntheMiddleOfTypingANumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsIntheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsIntheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func equals() {
            userIsIntheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func operate(sender: UIButton) {
        if userIsIntheMiddleOfTypingANumber {
            equals()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
        }
    }
    
}

