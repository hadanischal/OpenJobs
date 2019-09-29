//
//  ImageViewExtension.swift
//  OpenJobs
//
//  Created by Nischal Hada on 27/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    public func setImage(url: URL) {
        self.kf.setImage(with: url)
    }
}
