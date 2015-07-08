//
//  ViewController.swift
//  calC+
//
//  Created by Riyaz Ahamed on 13/04/15.
//  Copyright (c) 2015 iAppTest Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
            operandStack.append(displayValue)
    }
    
    func performOperation(operation : (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            equals()
        }
    }
    
    func performOperation1(operation : Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            equals()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsIntheMiddleOfTypingANumber {
            equals()
        }
        switch operation {
            case "+" : performOperation { $0 + $1 }
            case "−" : performOperation { $1 - $0 }
            case "×" : performOperation { $0 * $1 }
            case "÷" : performOperation { $1 / $0 }
            case "√" : performOperation1 { sqrt($0)}
            case "∏" : performOperation1 { $0 * M_PI }
            case "%" : performOperation { $1 % $0 }
            default : break
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

