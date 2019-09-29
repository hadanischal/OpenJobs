//
//  ConnectedBusinessModel.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - ConnectedBusiness
struct ConnectedBusinessModel: Codable {
    let businessID: Int64?
    let thumbnail: String?
    let isHired: Bool?

    enum CodingKeys: String, CodingKey {
        case businessID = "businessId"
        case thumbnail, isHired
    }
}

extension ConnectedBusinessModel {
    init(withConnectedBusiness businesses: ConnectedBusinesses) {
        self.businessID = businesses.businessId
        self.thumbnail = businesses.thumbnail
        self.isHired = businesses.isHired
    }
}
