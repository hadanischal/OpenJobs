//
//  JobsList.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - JobsList
struct JobsList: Codable {
    let jobs: [JobModel]
}

extension JobsList: Equatable {
    static func == (lhs: JobsList, rhs: JobsList) -> Bool {
        return lhs.jobs == rhs.jobs
    }
}
