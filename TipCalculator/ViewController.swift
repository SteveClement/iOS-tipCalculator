//
//  ViewController.swift
//  TipCalculator
//
//  Created by Steve Clement on 24/03/15.
//  Copyright (c) 2015 Steve Clement. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var totalTextField : UITextField!
    @IBOutlet var taxPctSlider : UISlider!
    @IBOutlet var taxPctLabel : UILabel!
    @IBOutlet var resultsTextView : UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

