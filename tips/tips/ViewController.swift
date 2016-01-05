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
    @IBOutlet weak var settingLabel: UIBarButtonItem!
    
    func getCurrentSecs()->Int64{
        return  Int64(NSDate().timeIntervalSince1970/60)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func langSetup() {
        tipTextLabel.text = NSLocalizedString("TipLabel", comment: "")
        totalTextLabel.text = NSLocalizedString("TotalLabel", comment: "")
        billTextLabel.text = NSLocalizedString("BillLabel", comment: "")
        settingLabel.title = NSLocalizedString("SettingLabel", comment: "")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        billFill.becomeFirstResponder()
        
        // setup for languagues
        langSetup()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.integerForKey("last_time") != 0 {
            var lastTime = defaults.integerForKey("last_time")
            var lastBill = defaults.doubleForKey("last_bill")
            var nowTime = Int(getCurrentSecs())
            if nowTime - lastTime < 10 {
                
                if lastBill != 0 {
                    billFill.text = String(format: "%.2f", lastBill)
                    calcTip()
                }
                else {
                    billFill.text = ""
                }
                
            } else {
                billFill.text = ""
            }
            
        }
        
        
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
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        tipLabel.text = formatter.stringFromNumber(0)
        totalLabel.text = formatter.stringFromNumber(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func calcTip() {
        var tipPers = [0.18, 0.20, 0.22]
        var tipPer = tipPers[tipControl.selectedSegmentIndex]
        var billAmount = (billFill.text as NSString).doubleValue
        var tip = billAmount * tipPer
        var total = billAmount + tip
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.billAmountLast = billAmount
    }

    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        calcTip()
    }
    @IBAction func OnTap(sender: AnyObject) {
        view.endEditing(true)
        
    }

}

