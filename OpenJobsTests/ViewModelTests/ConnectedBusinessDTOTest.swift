//
//  ConnectedBusinessDTOTest.swift
//  OpenJobsTests
//
//  Created by Nischal Hada on 26/7/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Nimble
@testable import OpenJobs
import Quick
import XCTest

final class ConnectedBusinessDTOTest: QuickSpec {
    override func spec() {
        describe("ConnectedBusinessDTO test") {
            let mockConnectedBusinessModel: ConnectedBusinessModel = (MockData().stubJobsList()!.jobs.first!.connectedBusinesses?.first)!
            var testModel: ConnectedBusinessDTO!

            beforeEach {
                testModel = ConnectedBusinessDTO(mockConnectedBusinessModel)
            }

            it("it sets ConnectedBusinessDTO correctly for index 0") {
                expect(testModel.thumbnail).to(equal("https://assets.homeimprovementpages.com.au/images/hui/avatars/a.png"))
                expect(testModel.isHired).to(beFalse())
                expect(testModel.description).to(equal(" Not Hired "))
            }
        }
    }
}
