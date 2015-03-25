//
//  ViewController.swift
//  TipCalculator
//
//  Created by Steve Clement on 24/03/15.
//  Copyright (c) 2015 Steve Clement. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // let is for constants and var for variables
    // tipCalc gets used in refreshUI() and makes use of our Model
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)

    // *** Outlets ***
    // IB == InterfaceBuilder (historical)
    // Outlet means you can set n' get "stuff"
    // The bang (!) at the end will unwrap the variables
    @IBOutlet var totalTextField : UITextField!
    @IBOutlet var taxPctSlider : UISlider!
    @IBOutlet var taxPctLabel : UILabel!
    @IBOutlet var resultsTextView : UITextView!
    
    // *** Actions ***
    // Actions mean senders
    @IBAction func calculateTapped(sender : AnyObject) {
        tipCalc.total = Double((totalTextField.text as NSString).doubleValue)
        let possibleTips = tipCalc.returnPossibleTips()
        var results = ""
        for (tipPct, tipValue) in possibleTips {
            results += "\(tipPct)%: \(tipValue)\n"
        }
        resultsTextView.text = results
    }
    @IBAction func taxPercentageChanged(sender : AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }
    @IBAction func viewTapped(sender : AnyObject) {
        totalTextField.resignFirstResponder()
    }

    
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
            totalTextField.text = String(format: "%0.2f", tipCalc.total)
            taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
            taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
            resultsTextView.text = ""
    }
}

