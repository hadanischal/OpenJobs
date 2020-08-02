//
//  CustomViewExtension.swift
//  OpenJobs
//
//  Created by Nischal Hada on 25/11/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import UIKit

extension UIView {
    func roundedCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }

    // Draw shadow to view
    func drawShadow(offset: CGSize, radius: CGFloat, opacity: Float) {
        self.layer.shadowColor = ColorName.shadowColor.color.cgColor// #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
    }
}
