//
//  ViewController.swift
//  TipCalculator
//
//  Created by Steve Clement on 24/03/15.
//  Copyright (c) 2015 Steve Clement. All rights reserved.
//

// In swift we import frameworks (similar to Python)
import UIKit

// This is our ViewController class inheriting from UIViewController
// Inheritance does not need class prefixing (Obj-C needed it for namespace collison avoidance)
class ViewController: UIViewController {

    // let is for constants and var for variables
    // tipCalc gets used in refreshUI() and makes use of our Model
    // This will also set our initial values for the different objects nb. they cannot be nil
    let tipCalc = TipCalculatorModel(total: 313.37, taxPct: 0.06)

    // *** Outlets ***
    // IB == InterfaceBuilder (historical)
    // Outlet means you can set n' get "stuff"
    // The bang (!) at the end will implicitly unwrap the variables
    @IBOutlet var totalTextField : UITextField!
    @IBOutlet var taxPctSlider : UISlider!
    @IBOutlet var taxPctLabel : UILabel!
    @IBOutlet var sortedLabel : UILabel!
    @IBOutlet var resultsTextView : UITextView!
    @IBOutlet var sortedSwitch: UISwitch!
    
    // *** Actions ***
    // Actions mean senders
    // When declaring callbacks for actions from views it assumes a function with no return value
    // and one parameter of type AnyObject (equivalent to 'id' in objC) which represents a class of any type
    @IBAction func calculateTapped(sender : AnyObject) {
        // This converts a String to a Double, not elegant but Swift has no cleaner way as of yet
        // NSString from ObjC Foundation has it so probably not ported yet
        // You can call (foo as NSString)() on a Swift String to convert it to an NSString
        // Now you can call any method that is available on NSString, such as a method to convert to a double
        tipCalc.total = Double((totalTextField.text as NSString).doubleValue)
        // Call to returnPossibleTips() on tipCalc model, this returns a dictionary
        let possibleTips = tipCalc.returnPossibleTips()
        var results = ""
        
        if sortedSwitch.on != true {
            // Here we enumerate thourgh keys and values if our dictionary, at the same time
            for (tipPct, tipValue) in possibleTips {
                results += "\(tipPct)%: \(tipValue)\n"
            }
        } else {

            // Add code to sort the results by tip percentage
            // Grab the keys in an array and store them temporarily
            var keys = Array(possibleTips.keys)
            // Sort the the keys
            sort(&keys)
            // Enumerate tipPct with our sorted keys variable
            for tipPct in keys {
                // Store tip value in variable (! unwraps it all)
                let tipValue = possibleTips[tipPct]!
                // Beautify the the tip value by truncating to 2 decimal places
                let prettyTipValue = String(format:"%.2f", tipValue)
                // Combine it all and store in a variable
                results += "\(tipPct)%: \(prettyTipValue)\n"
            }
            }
        // Populating result Text View
        resultsTextView.text = results
    }
    @IBAction func taxPercentageChanged(sender : AnyObject) {
        // this simply reverses our multplication
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }
    @IBAction func sortedChanged(sender : AnyObject) {
        // this simply reverses our multplication
        // sorted = false
        if sortedSwitch.on == true {
            sortedLabel.text = "Sorted"
        } else {
            sortedLabel.text = "Unsorted"
        }
    }

    @IBAction func viewTapped(sender : AnyObject) {
        // This will dismiss the keyboard
        totalTextField.resignFirstResponder()
    }

    // This will be called the first time the root view of this Viewcontroller is accessed
    // you have to use override explicitly when you override a function to avoid an accidental override
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        // This would be a good oportunity to run clean-up routines
        // This gets called when we run low on memory and gives us only a few seconds to do the clean-up
    }

    func refreshUI() {
        // In swift you need to be explicit when converting types
        // Here we convert a Double to a String
        totalTextField.text = String(format: "%0.2f", tipCalc.total)
        // /!\ /!\ /!\
        // This will make sure we see 6% instead of 0.06 (comment out to see what I mean)
        // /!\ Didn't see difference investigate /!\
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        // This will update the text next to the slider (string interpolation used)
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        // Clear the results Text View until we press calculate
        resultsTextView.text = ""
    }
}

