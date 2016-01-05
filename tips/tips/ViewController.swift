//
//  ViewController.swift
//  tips
//
//  Created by YiHuang on 12/28/15.
//  Copyright (c) 2015 c2fun. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var animationLoad: Bool = false
    @IBOutlet weak var billFill: UITextField!
    @IBOutlet weak var billTextLabel: UILabel!
    @IBOutlet weak var settingLabel: UIBarButtonItem!


    @IBOutlet weak var sepBar: UIView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipTextLabel: UILabel!
    @IBOutlet weak var totalTextLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!

    
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
    
    
    func hideControls() {
        // do animations
        tipLabel.center.y += view.bounds.height
        totalLabel.center.y += view.bounds.height
        tipTextLabel.center.y += view.bounds.height
        totalTextLabel.center.y += view.bounds.height
        tipControl.center.y += view.bounds.height
        sepBar.center.y += view.bounds.height
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        // setup for languagues
        langSetup()
        
        
        // Theme Setup
        if defaults.boolForKey("default_theme") == true {
            self.view.backgroundColor = UIColor(hex: "#262626")
            var darkTextColor = UIColor(hex: "#E2E4E2")
            billFill.textColor = darkTextColor
            tipLabel.textColor = darkTextColor
            totalLabel.textColor = darkTextColor
            totalTextLabel.textColor = darkTextColor
            tipTextLabel.textColor = darkTextColor
            billTextLabel.textColor = darkTextColor
            
        } else {
            self.view.backgroundColor = UIColor.whiteColor()
            tipLabel.textColor = UIColor.blackColor()
            billFill.textColor = UIColor.blackColor()
            totalLabel.textColor = UIColor.blackColor()
            totalTextLabel.textColor = UIColor.blackColor()
            tipTextLabel.textColor = UIColor.blackColor()
            billTextLabel.textColor = UIColor.blackColor()
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // hide all elements in UI
        hideControls()
        
        // load memorized bill amount
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        var currencySym = formatter.currencySymbol
        animationLoad = false
        billFill.becomeFirstResponder()
        
        
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.integerForKey("last_time") != 0 {
            var lastTime = defaults.integerForKey("last_time")
            var lastBill = defaults.doubleForKey("last_bill")
            var nowTime = Int(getCurrentSecs())
            if nowTime - lastTime < 10 {
                
                if lastBill != 0 {
                    if currencySym != nil {
                        billFill.text = currencySym! + String(format: "%.2f", lastBill)
                    }
                    else {
                        billFill.text = String(format: "$.2f", lastBill)
                    }
                    calcTip()
                }
                else {
                    if currencySym != nil {
                        billFill.text = currencySym!
                    }
                    else {
                        billFill.text = ""
                    }
                }
                
            } else {
                if currencySym != nil {
                    billFill.text = currencySym!
                }
                else {
                    billFill.text = ""
                }
            }
            
        }

        
        // Do any additional setup after loading the view, typically from a nib.
        tipControl.selectedSegmentIndex = defaults.integerForKey("default_tip_rate")
        tipLabel.text = formatter.stringFromNumber(0)
        totalLabel.text = formatter.stringFromNumber(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearTouched(sender: AnyObject) {
        animationLoad = false
        hideControls()
        billFill.text = ""
        calcTip()
    }

    func calcTip() {
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        var currencySym = formatter.currencySymbol
        if animationLoad == false {
            UIView.animateWithDuration(0.3, animations: {
                self.tipLabel.center.y -= self.view.bounds.height
                self.totalLabel.center.y -= self.view.bounds.height
                self.tipTextLabel.center.y -= self.view.bounds.height
                self.totalTextLabel.center.y -= self.view.bounds.height
                self.tipControl.center.y -= self.view.bounds.height
                self.sepBar.center.y -= self.view.bounds.height
                }, completion: nil)
            animationLoad = true
        }
        var tipPers = [0.18, 0.20, 0.22]
        var tipPer = tipPers[tipControl.selectedSegmentIndex]
        var billAmountStr = billFill.text
        
        if currencySym != nil {
            if billAmountStr.rangeOfString(currencySym!) != nil {
                billAmountStr = billAmountStr.stringByReplacingOccurrencesOfString(currencySym!, withString: "", options: nil, range: nil)
                print(billAmountStr)
            }
        }

        var billAmount = (billAmountStr as NSString).doubleValue
        var tip = billAmount * tipPer
        var total = billAmount + tip
        
        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.billAmountLast = billAmount
    }

    
    @IBAction func onEditingChanged(sender: AnyObject) {

        calcTip()
    }
    
    @IBAction func OnTap(sender: AnyObject) {
        view.endEditing(true)
        
    }

}

