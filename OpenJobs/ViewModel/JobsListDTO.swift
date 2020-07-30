//
//  JobsListDTO.swift
//  OpenJobs
//
//  Created by Nischal Hada on 22/7/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

struct JobsListDTO: Equatable {
    let category, postedDate, status: String
    let connectedBusinesses: [ConnectedBusinessDTO]
    let description: String

    init(_ data: JobModel) {
        category = data.category
        let date = data.postedDate.yyyyMMddDate?.ddMMyyyyString ?? data.postedDate
        postedDate = L10n.DashBoard.postedDate(date)
        status = data.status.capitalized
        connectedBusinesses = data.connectedBusinesses?.compactMap({ info -> ConnectedBusinessDTO in
            ConnectedBusinessDTO(info)
        }) ?? []

        if let businessList = data.connectedBusinesses,
            !businessList.isEmpty {
            description = L10n.DashBoard.businessCountDescription(businessList.count)
        } else {
            description = L10n.DashBoard.businessCountNill
        }
    }
}

struct ConnectedBusinessDTO: Equatable {
    let thumbnail: String
    let isHired: Bool
    let description: String

    init(_ data: ConnectedBusinessModel) {
        thumbnail = data.thumbnail ?? ""
        isHired = data.isHired ?? false
        description = data.isHired ?? false ? L10n.DashBoard.statusHired : L10n.DashBoard.statusNotHired
    }
}
