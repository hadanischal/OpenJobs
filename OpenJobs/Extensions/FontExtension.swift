//
//  FontExtension.swift
//  OpenJobs
//
//  Created by Nischal Hada on 27/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import UIKit

extension UIFont {
    class func boldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "SourceSansPro-Bold", size: size)!
    }
    class func regularFont(size: CGFloat) -> UIFont {
        return UIFont(name: "SourceSansPro-Regular", size: size)!
    }
    class func lightFont(size: CGFloat) -> UIFont {
        return UIFont(name: "SourceSansPro-Light", size: size)!
    }
}

extension UIFont {
    static var navigationBarTitle: UIFont {
        return .regularFont(size: 22)
    }
    static var navigationBarButtonItem: UIFont {
        return .lightFont(size: 20)
    }
    static var heading1: UIFont {
        return .boldFont(size: 25)
    }
    static var heading2: UIFont {
        return .boldFont(size: 20)
    }
    static var body1: UIFont {
        return .regularFont(size: 20)
    }
    static var body2: UIFont {
        return .lightFont(size: 20)
    }
    static var body3: UIFont {
        return .lightFont(size: 18)
    }
    static var detailTitle: UIFont {
        return .lightFont(size: 16)
    }
    static var detailBody: UIFont {
        return .regularFont(size: 24)
    }
    static var segmentTitle: UIFont {
        return .regularFont(size: 17)
    }
    static var textButton: UIFont {
        return .boldFont(size: 25)
    }
}
