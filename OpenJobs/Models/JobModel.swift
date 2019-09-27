//
//  JobModel.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - Job
struct JobModel: Codable {
    let jobID: Int
    let category, postedDate, status: String
    let connectedBusinesses: [ConnectedBusiness]?
    let detailsLink: String

    enum CodingKeys: String, CodingKey {
        case jobID = "jobId"
        case category, postedDate, status, connectedBusinesses, detailsLink
    }
}

extension JobModel: Equatable {
    static func == (lhs: JobModel, rhs: JobModel) -> Bool {
        return lhs.jobID == rhs.jobID
        && lhs.status == rhs.status
        && lhs.category == rhs.category
        && lhs.postedDate == rhs.postedDate
        && lhs.detailsLink == rhs.detailsLink
    }
}
