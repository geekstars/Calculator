//
//  ViewController.swift
//  Calculator
//
//  Created by Hoàng Minh Thành on 8/24/16.
//  Copyright © 2016 Hoàng Minh Thành. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var distanceBetween: NSLayoutConstraint!
    @IBOutlet weak var distanceBetweenResultLabelAndMiddleView: NSLayoutConstraint!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var ResultLabel: UILabel!
    
    var isTappingNumber : Bool = false
    var isEndOperation : Bool = false
    var firstNumber : Double = 0
    var secondNumber : Double = 0
    var operation : String = ""
    var isDot : Bool = false
    var dotcount:UInt32 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.userInteractionEnabled = false
    }

    // Number Actions
    
    @IBAction func numberAction(sender: UIButton)
    {
        isDot = true
        let number = sender.currentTitle
        if isTappingNumber {
            inputTextField.text = inputTextField.text! + number!
        }
        else
        {
            inputTextField.text = number
            isTappingNumber = true
        }
    }
    // Operator Actions
    
    @IBAction func dotAction(sender: UIButton) {
        if isDot == true && dotcount < 1
        {
            inputTextField.text = inputTextField.text! + "."
            isDot = false
            dotcount = dotcount + 1
        }
    }
    @IBAction func operatorAction(sender: UIButton)
    {
        operation = sender.currentTitle!
        dotcount = 0
        isDot = false
        if let inputOperation = Double(inputTextField.text!) {
            if isEndOperation {
                firstNumber = inputOperation
                isEndOperation = false
            }
            else
            {
                firstNumber = Double(ResultLabel.text!)!
                isEndOperation = true
            }
        }
        else {
            print("Bạn cần nhập số vào trước")
            isEndOperation = true
        }
        isTappingNumber = false
        if operation == "%" {
            ResultAction(sender)
        }
        else
        {
            if operation == "+/-"{
                ResultAction(sender)
            }
        }
    }
    // Result Action
    
    @IBAction func ResultAction(sender: UIButton) {
        isTappingNumber = false
        dotcount = 0
        var result : Double = 0
        if let realSecondNumber = Double(inputTextField.text!) {
            secondNumber = realSecondNumber
        }
        switch operation {
        case "+":
            result = firstNumber + secondNumber
        case "-":
            result = firstNumber - secondNumber
        case "*":
            result = firstNumber * secondNumber
        case "/":
            result = Double(firstNumber)/Double(secondNumber)
        case "%":
            result = firstNumber / 100
        case "+/-":
            if firstNumber < 0 {
                firstNumber = fabs(firstNumber)
                result = firstNumber
            }else{
                firstNumber = -1 * firstNumber
                result = firstNumber
            }
            inputTextField.text = "\(result)"
        default:
            print("Error Operation")
        }
        let dou = Double(result%1)
        let int = dou*10
        if int <= 0 {
            ResultLabel.text = "\(result)"
        }
        else
        {
            ResultLabel.text = "\(String(format: "%0.8f",result))"
        }
    }
    // AC Action
    @IBAction func ACAction(sender: UIButton) {
        
        firstNumber = 0
        secondNumber = 0
        inputTextField.text = ""
        ResultLabel.text = "0"
        isEndOperation = true
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
        updateContraints()
    }

    func updateContraints() -> Void {
        let scale = UIScreen.mainScreen().bounds.size.height/667
        distanceBetweenResultLabelAndMiddleView.constant = UIScreen.mainScreen().bounds.size.height > 480 ? distanceBetweenResultLabelAndMiddleView.constant * scale : distanceBetweenResultLabelAndMiddleView.constant * 0.1
        distanceBetween.constant = UIScreen.mainScreen().bounds.size.height > 480 ? distanceBetween.constant * scale : distanceBetween.constant * 0.1
        
    }
}

