//
//  ColourConstant.swift
//  OpenJobs
//
//  Created by Nischal Hada on 27/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import UIKit

extension UIColor {
    static var primary: UIColor {
        return UIColor(rgb: 0xEf8136)
    }
    static var viewBackgroundColor: UIColor {
        return UIColor(rgb: 0xeef0f1)
    }
    static var tableViewBackgroundColor: UIColor {
        return UIColor(rgb: 0xEEEEEE)
    }
    static var barTintColor: UIColor {
        return UIColor.white
    }
    static var titleTintColor: UIColor {
        return UIColor.white
    }
    static var dimBlackColor: UIColor {
        return UIColor(rgb: 0x141414)
    }
    static var coral: UIColor {
        return UIColor(red: 244, green: 111, blue: 96)
    }
    static var segmentSelectedTitle: UIColor {
        return UIColor.black
    }
    static var segmentDefaultTitle: UIColor {
        return UIColor.darkGray
    }
    static var segmentIndicator: UIColor {
        return UIColor(rgb: 0xEf8136)
    }
    static var segmentSeparator: UIColor {
        return UIColor(rgb: 0xDDDDDD)
    }
    static var cellBorderColor: UIColor {
        return UIColor(rgb: 0xDDDDDD)
    }

    static var statusColor: UIColor {
        return UIColor(rgb: 0x51B6BB)
    }
    static var titleColor: UIColor {
        return UIColor.black
    }
    static var descriptionColor: UIColor {
        return UIColor.lightGray
    }
}

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}
