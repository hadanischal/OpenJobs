//
//  ReusableView.swift
//  OpenJobs
//
//  Created by Nischal Hada on 29/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import UIKit

protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}

extension UICollectionViewCell: ReusableView {}
