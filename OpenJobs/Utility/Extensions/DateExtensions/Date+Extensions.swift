//
//  Date+Extensions.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation

extension Date {
    var ddMMyyyyString: String {
        return DateFormatter.ddMMyyyy.string(from: self)
    }

    var ddMMyyString: String {
        return DateFormatter.ddMMyy.string(from: self)
    }

    var MMyyyyString: String {
        return DateFormatter.MMyyyy.string(from: self)
    }
}
