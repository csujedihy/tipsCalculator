//
//  Util.swift
//  tips
//
//  Created by YiHuang on 1/4/16.
//  Copyright (c) 2016 c2fun. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        let characterSet = NSCharacterSet.whitespaceAndNewlineCharacterSet().mutableCopy() as! NSMutableCharacterSet
        characterSet.formUnionWithCharacterSet(NSCharacterSet(charactersInString: "#"))
        var cString = hex.stringByTrimmingCharactersInSet(characterSet).uppercaseString
        if (count(cString) != 6) {
            self.init(white: 1.0, alpha: 1.0)
        } else {
            var rgbValue: UInt32 = 0
            NSScanner(string: cString).scanHexInt(&rgbValue)
            
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0))
        }
    }
}
