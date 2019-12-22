//
//  JobsListInteractorTest.swift
//  OpenJobsTests
//
//  Created by Nischal Hada on 22/12/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Cuckoo
import RxTest
import RxBlocking
import RxSwift

@testable import OpenJobs

class JobsListInteractorTest: QuickSpec {

    override func spec() {
        var testViewModel: JobsListInteractor!
        var mockGetJobsHandler: MockGetJobsHandlerProtocol!
        var mockCoreDataManager: MockCoreDataManagerDataSource!
        var testScheduler: TestScheduler!
        let mockJobsList = MockData().stubJobsList()

        describe("JobsListInteractor") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockGetJobsHandler = MockGetJobsHandlerProtocol()
                stub(mockGetJobsHandler, block: { stub in
                    when(stub.getJobs()).thenReturn(Observable.empty())
                })

                mockCoreDataManager = MockCoreDataManagerDataSource()
                stub(mockCoreDataManager, block: { stub in
                    when(stub.fetchJobList()).thenReturn(Single.just([]))
                    when(stub.saveInCoreDataWith(withJobList: any())).thenReturn(Completable.empty())
                })
                testViewModel = JobsListInteractor(withSourcesHandler: mockGetJobsHandler,
                                                   withCoreDataManager: mockCoreDataManager)
            }

            describe("Get Jobs from server succeed", {

                context("when server request succeed for get jobs list", {
                    beforeEach {
                        stub(mockGetJobsHandler, block: { stub in
                            when(stub.getJobs()).thenReturn(Observable.just(mockJobsList))
                        })
                    }
                    it("calls to the mockGetJobsHandler to fetchJobList", closure: {
                        let observable = testViewModel.getJobs().asObservable()
                        _ = testScheduler.start {
                            observable
                        }
                        verify(mockGetJobsHandler).getJobs()
                    })

                    it("emits the jobs list to the UI", closure: {
                        let observable = testViewModel.getJobs().asObservable()
                        let res = testScheduler.start {
                            observable
                        }
                        expect(res.events.count).to(equal(2))
                        let mockData: [JobModel] = MockData().stubJobsList()!.jobs
                        let correctResult = [Recorded.next(200, mockData),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })

                context("when server request failed for get jobs", {
                    beforeEach {
                        stub(mockGetJobsHandler, block: { stub in
                            when(stub.getJobs()).thenReturn(Observable.error(mockError))
                        })
                    }
                    it("it completed successfully", closure: {
                        let observable = testViewModel.getJobs().asObservable()
                        _ = testScheduler.start {
                            observable
                        }
                        verify(mockGetJobsHandler).getJobs()
                    })
                    it("doesnt emits jobs list to the UI", closure: {
                        let observable = testViewModel.getJobs().asObservable()
                        let res = testScheduler.start {
                            observable
                        }
                        expect(res.events).toNot(beNil())
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.completed(200, [JobModel].self)]
                        expect(res.events).to(equal(correctResult))
                    })
                })
            })

            describe("Get Jobs list from local DB", {

                describe("when local DB request succeed for get jobs list", {
                    beforeEach {
                        stub(mockCoreDataManager, block: { stub in
                            when(stub.saveInCoreDataWith(withJobList: any())).thenReturn(Completable.empty())
                            when(stub.fetchJobList()).thenReturn(Single.just(MockData().jobsOpen))
                        })
                    }
                    it("calls to the mockCoreDataManager to fetchJobList", closure: {
                        let observable = testViewModel.getJobs().asObservable()
                        _ = testScheduler.start {
                            observable
                        }
                        verify(mockCoreDataManager).fetchJobList()
                    })

                    it("emits the jobs list to the UI", closure: {
                        let observable = testViewModel.getJobs().asObservable()
                        let res = testScheduler.start {
                            observable
                        }
                        expect(res.events.count).to(equal(2))
                        let mockData: [JobModel] = MockData().jobsOpen
                        let correctResult = [Recorded.next(200, mockData),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })

                describe("when local DB request failed for get jobs", {
                    beforeEach {
                        stub(mockCoreDataManager, block: { stub in
                            when(stub.saveInCoreDataWith(withJobList: any())).thenReturn(Completable.empty())
                            when(stub.fetchJobList()).thenReturn(Single.error(mockError))
                        })
                    }
                    it("calls to the mockCoreDataManager to fetchJobList", closure: {
                        let observable = testViewModel.getJobs().asObservable()
                        _ = testScheduler.start {
                            observable
                        }
                        verify(mockCoreDataManager).fetchJobList()
                    })
                    it("emits empty list to the UI", closure: {
                        let observable = testViewModel.getJobs().asObservable()
                        let res = testScheduler.start {
                            observable
                        }
                        expect(res.events).toNot(beNil())
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.completed(200, [JobModel].self)]
                        expect(res.events).to(equal(correctResult))
                    })
                })
            })
        }
    }
}
