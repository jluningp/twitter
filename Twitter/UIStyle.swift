//
//  UIStyle.swift
//  Twitter
//
//  Created by Jeanne Luning Prak on 6/27/16.
//  Copyright © 2016 Jeanne Luning Prak. All rights reserved.
//

import Foundation
import UIKit

class UIStyle {
    
    var backgroundColor : UIColor
    var twitterColor : UIColor
    var boldFont : UIFont
    var fontSize : CGFloat
    var normalFont : UIFont
    
    init() {
        backgroundColor = .whiteColor()
        twitterColor = UIColor(red:0.20, green:0.60, blue:1.00, alpha:1.0)
        fontSize = 14.0
        boldFont = UIFont.boldSystemFontOfSize(fontSize)
        normalFont = UIFont.systemFontOfSize(fontSize)
    }
    
    func makeHeader() -> UILabel {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.Center
        label.text = "Twitter"
        label.textColor = .whiteColor()
        label.backgroundColor = UIColor(red:0.20, green:0.60, blue:1.00, alpha:1.0)
        return label
    }
    
}
