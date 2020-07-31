//
//  FontExtension.swift
//  OpenJobs
//
//  Created by Nischal Hada on 27/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import UIKit

extension UIFont {
    static func boldFont(size: CGFloat) -> UIFont {
        UIFont(font: FontFamily.SourceSansPro.bold, size: size)
    }

    static func regularFont(size: CGFloat) -> UIFont {
        UIFont(font: FontFamily.SourceSansPro.regular, size: size)
    }

    static func lightFont(size: CGFloat) -> UIFont {
        UIFont(font: FontFamily.SourceSansPro.light, size: size)
    }

    static func kittenSwashFont(size: CGFloat) -> UIFont {
        UIFont(font: FontFamily.KittenSwash.regular, size: size)
    }
}

extension UIFont {
    static var navigationBarTitle: UIFont { .kittenSwashFont(size: 22) }

    static var navigationBarButtonItem: UIFont { .lightFont(size: 20) }

    static var heading1: UIFont { .boldFont(size: 25) }

    static var heading2: UIFont { .boldFont(size: 20) }

    static var body1: UIFont { .regularFont(size: 20) }

    static var body2: UIFont { .lightFont(size: 20) }

    static var body3: UIFont { .lightFont(size: 18) }

    static var detailTitle: UIFont { .lightFont(size: 16) }

    static var detailBody: UIFont { .regularFont(size: 24) }

    static var segmentTitle: UIFont { .regularFont(size: 17) }

    static var textButton: UIFont { .boldFont(size: 25) }

    static var statusTitle: UIFont { .boldFont(size: 16) }
}
