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
    @IBOutlet weak var tipTextLabel: UILabel!
    @IBOutlet weak var totalTextLabel: UILabel!
    @IBOutlet weak var billTextLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        billFill.becomeFirstResponder()
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey("default_theme") == true {
            self.view.backgroundColor = UIColor.darkGrayColor()
            tipLabel.textColor = UIColor.whiteColor()
            totalLabel.textColor = UIColor.whiteColor()
            totalTextLabel.textColor = UIColor.whiteColor()
            tipTextLabel.textColor = UIColor.whiteColor()
            billTextLabel.textColor = UIColor.whiteColor()
            
        } else {
            self.view.backgroundColor = UIColor.whiteColor()
            tipLabel.textColor = UIColor.blackColor()
            totalLabel.textColor = UIColor.blackColor()
            totalTextLabel.textColor = UIColor.blackColor()
            tipTextLabel.textColor = UIColor.blackColor()
            billTextLabel.textColor = UIColor.blackColor()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let defaults = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = defaults.integerForKey("default_tip_rate")
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

