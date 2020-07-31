//
//  SegmentModel.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation

enum SegmentModel: Int {
    case openJobs
    case closedJobs
}

extension SegmentModel {
    var jobStatusValue: String {
        switch self {
        case .openJobs:
            return JobStatus.inProgress.rawValue
        case .closedJobs:
            return JobStatus.closed.rawValue
        }
    }
}
