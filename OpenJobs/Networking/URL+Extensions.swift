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
    static let baseServerURL = "https://gist.githubusercontent.com/hadanischal/47ec8878164b7cdf7f66fe45092673fc/raw/9dd9e33e50bee5e2b9f40ba2bda95a67e6c7aa9a/jobs.json"

}
