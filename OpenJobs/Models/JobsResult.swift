//
//  JobModel.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - JobsResult

struct JobsResult: Codable {
    let jobs: [JobModel]
}

// MARK: - Job

struct JobModel: Codable, Equatable {
    let jobID: Int64
    let category, postedDate, status: String
    let connectedBusinesses: [ConnectedBusinessModel]?
    let detailsLink: String

    enum CodingKeys: String, CodingKey {
        case jobID = "jobId"
        case category, postedDate, status, connectedBusinesses, detailsLink
    }
}

extension JobModel {
    init(withJobs jobs: Jobs) {
        self.jobID = jobs.jobId
        self.category = jobs.category ?? ""
        self.postedDate = jobs.postedDate ?? ""
        self.status = jobs.status ?? ""
        self.detailsLink = jobs.detailsLink ?? ""
        let connectedBusiness = jobs.connectedBusinesses?.allObjects as? [ConnectedBusinesses]
        self.connectedBusinesses = connectedBusiness?.map {
            ConnectedBusinessModel(withConnectedBusiness: $0)
        }
    }
}
