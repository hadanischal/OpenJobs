//
//  JobsListDTOTest.swift
//  OpenJobsTests
//
//  Created by Nischal Hada on 26/7/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Nimble
@testable import OpenJobs
import Quick
import XCTest

final class JobsListDTOTest: QuickSpec {
    override func spec() {
        describe("JobsListDTOTest test") {
            let mockJobModel: JobModel = MockData().stubJobsList()!.jobs.first!
            var testModel: JobsListDTO!

            beforeEach {
                testModel = JobsListDTO(mockJobModel)
            }

            it("it sets JobsListDTO correctly") {
                expect(testModel.category).to(equal("Electricians"))
                expect(testModel.postedDate).to(equal("Posted: 13 April 2017"))
                expect(testModel.status).to(equal("In Progress"))
                expect(testModel.description).to(equal("You have hired 4 businesses"))
                expect(testModel.connectedBusinesses.count).to(equal(4))
            }

            it("it sets ConnectedBusinessDTO correctly for index 0") {
                let connectedBusinesses = testModel.connectedBusinesses[0]
                expect(connectedBusinesses.thumbnail).to(equal("https://assets.homeimprovementpages.com.au/images/hui/avatars/a.png"))
                expect(connectedBusinesses.isHired).to(beFalse())
                expect(connectedBusinesses.description).to(equal(" Not Hired "))
            }

            it("it sets ConnectedBusinessDTO correctly for index 1") {
                let connectedBusinesses = testModel.connectedBusinesses[1]
                expect(connectedBusinesses.thumbnail).to(equal("https://assets.homeimprovementpages.com.au/images/hui/avatars/p.png"))
                expect(connectedBusinesses.isHired).to(beTrue())
                expect(connectedBusinesses.description).to(equal(" Hired "))
            }

            it("it sets ConnectedBusinessDTO correctly for index 2") {
                let connectedBusinesses = testModel.connectedBusinesses[2]
                expect(connectedBusinesses.thumbnail).to(equal("https://assets.homeimprovementpages.com.au/images/hui/avatars/i.png"))
                expect(connectedBusinesses.isHired).to(beFalse())
                expect(connectedBusinesses.description).to(equal(" Not Hired "))
            }

            it("it sets ConnectedBusinessDTO correctly for index 3") {
                let connectedBusinesses = testModel.connectedBusinesses[3]
                expect(connectedBusinesses.thumbnail).to(equal("https://assets.homeimprovementpages.com.au/images/hui/avatars/g.png"))
                expect(connectedBusinesses.isHired).to(beTrue())
                expect(connectedBusinesses.description).to(equal(" Hired "))
            }
        }
    }
}
