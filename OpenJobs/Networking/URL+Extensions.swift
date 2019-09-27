//
//  URL+Extensions.swift
//  OpenJobs
//
//  Created by Nischal Hada on 26/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation

extension URL {
    static func sourcesUrl() -> URL? {
        return URL(string: ApiConstant.baseServerURL + ApiConstant.topJobs)
    }
}

struct ApiConstant {
    static let baseServerURL = "https://s3-ap-southeast-2.amazonaws.com"
    static let topJobs = "/hipgrp-assets/tech-test/jobs.json"
}
