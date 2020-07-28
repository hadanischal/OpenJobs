//
//  ConnectedBusinessModel.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - ConnectedBusiness

struct ConnectedBusinessModel: Codable, Equatable {
    let businessId: Int64?
    let thumbnail: String?
    let isHired: Bool?
}

extension ConnectedBusinessModel {
    init(withConnectedBusiness businesses: ConnectedBusinesses) {
        self.businessId = businesses.businessId
        self.thumbnail = businesses.thumbnail
        self.isHired = businesses.isHired
    }
}
