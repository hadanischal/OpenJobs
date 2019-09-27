//
//  ConnectedBusiness.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - ConnectedBusiness
struct ConnectedBusiness: Codable {
    let businessID: Int?
    let thumbnail: String?
    let isHired: Bool?

    enum CodingKeys: String, CodingKey {
        case businessID = "businessId"
        case thumbnail, isHired
    }
}
