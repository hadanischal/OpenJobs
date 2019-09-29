//
//  UITableView+Extensions.swift
//  OpenJobs
//
//  Created by Nischal Hada on 27/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import UIKit

extension UITableView {
    func hideEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }
}
