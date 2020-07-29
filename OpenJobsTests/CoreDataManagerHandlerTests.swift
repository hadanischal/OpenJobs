//
//  CoreDataManagerHandlerTests.swift
//  OpenJobsTests
//
//  Created by Nischal Hada on 26/7/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Cuckoo
import Nimble
import Quick
import RxBlocking
import RxSwift
import RxTest

@testable import OpenJobs

class CoreDataManagerHandlerTests: QuickSpec {
    override func spec() {
        var testHandler: CoreDataManagerHandler!
        var testScheduler: TestScheduler!
        let mockJobsList: [JobModel]! = MockData().stubJobsList()?.jobs.filter { $0.status == JobStatus.closed.rawValue.lowercased() }

        describe("CoreDataManager") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                testHandler = CoreDataManagerHandler()
            }

            describe("when save Jobs List to local DB succeed ", {
                var result: MaterializedSequenceResult<Never>?
                beforeEach {
                    result = testHandler.saveInCoreDataWith(withJobList: mockJobsList).toBlocking().materialize()
                }
                it("it completed successfully", closure: {
                    result?.assertSequenceCompletes()
                })
            })

            describe("when get jobs Closed Jobs List from local DB succeed ", {
                var result: MaterializedSequenceResult<Never>?

                beforeEach {
                    result = testHandler.saveInCoreDataWith(withJobList: mockJobsList).toBlocking().materialize()
                }
                it("it completed successfully", closure: {
                    result?.assertSequenceCompletes()
                })
                it("return the news list from DB", closure: {
                    let observable = testHandler.fetchJobList().asObservable()

                    let res = testScheduler.start { observable }
                    expect(res.events.count).to(equal(2))
                    let correctResult: [Recorded<Event<[JobModel]>>] = [Recorded.next(200, mockJobsList),
                                                                        Recorded.completed(200)]
                    expect(res.events).to(equal(correctResult))
                })
            })
        }
    }
}
