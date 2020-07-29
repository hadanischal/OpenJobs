//
//  CustomButton.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import UIKit

final class CustomButton: UIButton {
    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.tintColor = UIColor.clear
        self.setTitleColor(UIColor.primary, for: .normal)
        self.setBackgroundColor(UIColor.clear, for: .normal)
        self.setBackgroundColor(UIColor.clear, for: .highlighted)
        self.titleLabel?.font = UIFont.textButton
        self.titleLabel?.minimumScaleFactor = 0.5
        self.titleLabel?.adjustsFontSizeToFitWidth = true
    }

    private func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(image(withColor: color), for: state)
    }

    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}
