//
//  ImageViewExtension.swift
//  OpenJobs
//
//  Created by Nischal Hada on 27/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(url: URL?) {
        self.kf.setImage(with: url, placeholder: Asset.Icons.placeholder.image)
    }
}
