//
//  NibLoadableView.swift
//  OpenJobs
//
//  Created by Nischal Hada on 26/7/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import UIKit

protocol NibLoadableView: AnyObject {}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableViewCell: NibLoadableView {}
extension UICollectionViewCell: NibLoadableView {}
