//
//  String+Extension .swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation

extension String {
    var yyyyMMddDate: Date? {
        return DateFormatter.yyyyMMdd.date(from: self)
    }
}
