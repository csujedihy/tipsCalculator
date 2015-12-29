//
//  ViewController.swift
//  tips
//
//  Created by YiHuang on 12/28/15.
//  Copyright (c) 2015 c2fun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billFill: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPers = [0.18, 0.20, 0.22]
        var tipPer = tipPers[tipControl.selectedSegmentIndex]
        
        var billAmount = (billFill.text as NSString).doubleValue
        var tip = billAmount * tipPer
        var total = billAmount + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        
    }
    @IBAction func OnTap(sender: AnyObject) {
        view.endEditing(true)
        
    }

}

