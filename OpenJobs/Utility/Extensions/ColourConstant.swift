//
//  ColourConstant.swift
//  OpenJobs
//
//  Created by Nischal Hada on 27/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import UIKit

extension UIColor {
    static var primary: UIColor { ColorName.primary.color }

    static var viewBackgroundColor: UIColor { ColorName.viewBGColor.color }

    static var tableViewBackgroundColor: UIColor { ColorName.tableViewBGColor.color }

    static var barTintColor: UIColor { UIColor.white }

    static var titleTintColor: UIColor { UIColor.black }

    static var statusTextColor: UIColor { UIColor.white }

    static var coral: UIColor { ColorName.coral.color }

    static var segmentSelectedTitle: UIColor { UIColor.primary }

    static var segmentDefaultTitle: UIColor { UIColor.black }

    static var segmentIndicator: UIColor { UIColor.primary }

    static var segmentSeparator: UIColor { ColorName.lightSilver.color }

    static var cellBorderColor: UIColor { ColorName.lightSilver.color }

    static var statusColor: UIColor { UIColor.primary }

    static var titleColor: UIColor { UIColor.black }

    static var descriptionColor: UIColor { UIColor.lightGray }
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
