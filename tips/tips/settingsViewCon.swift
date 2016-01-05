//
//  settingsViewCon.swift
//  
//
//  Created by YiHuang on 12/31/15.
//
//

import UIKit

class settingsViewCon: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!

    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var defaultTipCon: UISegmentedControl!
    @IBOutlet weak var themeCon: UISwitch!
    
    @IBOutlet weak var defaultTipTextLabel: UILabel!
    @IBOutlet weak var darkThemeTextLabel: UILabel!
    
    @IBAction func onThemeChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(themeCon.on, forKey: "default_theme")
        defaults.synchronize()
        setDarkTheme()
    }
    
    @IBAction func onValChanged(sender: AnyObject) {
        var defaultTip = defaultTipCon.selectedSegmentIndex
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTip, forKey: "default_tip_rate")
        defaults.synchronize()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupLang()
    }
    
    func setupLang() {
        defaultTipTextLabel.text = NSLocalizedString("defaultTipTextLabel", comment: "")
        darkThemeTextLabel.text = NSLocalizedString("darkThemeTextLabel", comment: "")

    }
    
    
    func setDarkTheme() {
        if themeCon.on == true {

            self.view.backgroundColor = UIColor.darkGrayColor()
            tipLabel.textColor = UIColor.whiteColor()
            themeLabel.textColor = UIColor.whiteColor()
        
        }
        else {
            self.view.backgroundColor = UIColor.whiteColor()
            tipLabel.textColor = UIColor.blackColor()
            themeLabel.textColor = UIColor.blackColor()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        defaultTipCon.selectedSegmentIndex = defaults.integerForKey("default_tip_rate")
        themeCon.setOn(defaults.boolForKey("default_theme"), animated: false)
        setDarkTheme()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
