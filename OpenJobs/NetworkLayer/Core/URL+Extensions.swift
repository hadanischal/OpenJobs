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
        return URL(string: ApiConstant.baseServerURL)
    }
}

struct ApiConstant {
    static let baseServerURL = "https://gist.githubusercontent.com/hadanischal/87ddd87212b2e0baa22603ec6aac2950/raw/613d33b9a5689f8c1ec404fe9bd218f28466ca34/jobs.json"
}
