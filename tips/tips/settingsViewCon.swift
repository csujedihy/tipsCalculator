//
//  settingsViewCon.swift
//  
//
//  Created by YiHuang on 12/31/15.
//
//

import UIKit

class settingsViewCon: UIViewController {

    @IBOutlet weak var defaultTipCon: UISegmentedControl!
    
    @IBAction func onValChanged(sender: AnyObject) {
        var defaultTip = defaultTipCon.selectedSegmentIndex
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTip, forKey: "default_tip_rate")
        defaults.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        defaultTipCon.selectedSegmentIndex = defaults.integerForKey("default_tip_rate")
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
