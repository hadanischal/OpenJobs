//
//  GetJobsHandlerTests.swift
//  OpenJobsTests
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Cuckoo
import Nimble
import Quick
import RxBlocking
import RxSwift
import RxTest
import XCTest

@testable import OpenJobs

class GetJobsHandlerTests: QuickSpec {
    override func spec() {
        var testHandler: GetJobsHandler!
        var mockWebService: MockWebServiceProtocol!
        var testScheduler: TestScheduler!
        let mockJobsList = MockData().stubJobsList()

        describe("GetJobsHandler") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockWebService = MockWebServiceProtocol()

                stub(mockWebService, block: { stub in
                    when(stub.load(resource: any(Resource<JobsList>.self))).thenReturn(Observable.empty())
                })
                testHandler = GetJobsHandler(withWebService: mockWebService)
            }

            context("when get Jobs List server request succeed ", {
                beforeEach {
                    stub(mockWebService, block: { stub in
                        when(stub.load(resource: any(Resource<JobsList>.self))).thenReturn(Observable.just(mockJobsList!))
                    })
                }
                it("it completed successfully", closure: {
                    _ = testHandler.getJobs()
                    verify(mockWebService).load(resource: any(Resource<JobsList>.self))
                })
                it("emits the news list to the UI", closure: {
                    let observable = testHandler.getJobs().asObservable()

                    let res = testScheduler.start { observable }
                    expect(res.events.count).to(equal(2))
                    let correctResult = [Recorded.next(200, mockJobsList!.jobs),
                                         Recorded.completed(200)]
                    expect(res.events).to(equal(correctResult))
                })
            })

            context("when get Jobs List server request failed ", {
                beforeEach {
                    stub(mockWebService, block: { stub in
                        when(stub.load(resource: any(Resource<JobsList>.self))).thenReturn(Observable.error(mockError))
                    })
                }
                it("it completed successfully", closure: {
                    _ = testHandler.getJobs().asObservable()
                    verify(mockWebService).load(resource: any(Resource<JobsList>.self))
                })
                it("emits the news list to the UI", closure: {
                    let observable = testHandler.getJobs().asObservable()

                    let res = testScheduler.start { observable }
                    expect(res.events.count).to(equal(1))
                    let correctResult: [Recorded<Event<[JobModel]>>] = [Recorded.error(200, mockError, [JobModel].self)]
                    expect(res.events).to(equal(correctResult))
                })
            })
        }
    }
}
