//
//  CoreDataManagerTests.swift
//  OpenJobsTests
//
//  Created by Nischal Hada on 1/10/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//
//swiftlint:disable all
import XCTest
import Quick
import Nimble
import Cuckoo
import RxTest
import RxBlocking
import RxSwift

@testable import OpenJobs

class CoreDataManagerTests: QuickSpec {
    
    override func spec() {
        var testHandler: CoreDataManager!
        var testScheduler: TestScheduler!

        describe("CoreDataManager") {
            
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                testHandler = CoreDataManager()
            }
            
            describe("when save Jobs List to local DB succeed ", {
                var result: MaterializedSequenceResult<Never>?
                beforeEach {
                    result = testHandler.saveInCoreDataWith(withJobList: MockData().jobsOpen).toBlocking().materialize()
                }
                it("it completed successfully", closure: {
                    result?.assertSequenceCompletes()
                })
            })
            
            describe("when get jobs Closed Jobs List from local DB succeed ", {
                var result: MaterializedSequenceResult<Never>?
                
                beforeEach {
                    result = testHandler.saveInCoreDataWith(withJobList: MockData().jobsClosed).toBlocking().materialize()
                }
                it("it completed successfully", closure: {
                    result?.assertSequenceCompletes()
                })
                it("return the news list from DB", closure: {
                    let observable = testHandler.fetchJobList().asObservable()
                    
                    let res = testScheduler.start { observable }
                    expect(res.events.count).to(equal(2))
                    let correctResult = [Recorded.next(200, MockData().jobsClosed),
                                         Recorded.completed(200)]
                    expect(res.events).to(equal(correctResult))
                })
            })
        }
    }
}

