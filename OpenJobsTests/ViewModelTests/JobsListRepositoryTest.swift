//
//  JobsListRepositoryTest.swift
//  OpenJobsTests
//
//  Created by Nischal Hada on 22/12/19.
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

class JobsListRepositoryTest: QuickSpec {
    override func spec() {
        var testRepository: JobsListRepository!
        var mockNetworkHandling: MockJobsNetworkHandling!
        var mockCoreDataManager: MockCoreDataManagerHandling!
        var testScheduler: TestScheduler!
        let mockJobsList = MockData().stubJobsList()
        let mockJobsListDTO: [JobsListDTO]! = MockData().stubJobsListDTO()

        describe("JobsListRepository Test") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockNetworkHandling = MockJobsNetworkHandling()
                stub(mockNetworkHandling, block: { stub in
                    when(stub.getJobs()).thenReturn(Observable.empty())
                })

                mockCoreDataManager = MockCoreDataManagerHandling()
                stub(mockCoreDataManager, block: { stub in
                    when(stub.fetchJobList()).thenReturn(Single.just([]))
                    when(stub.saveInCoreDataWith(withJobList: any())).thenReturn(Completable.empty())
                })
                testRepository = JobsListRepository(withSourcesHandler: mockNetworkHandling,
                                                    withCoreDataManager: mockCoreDataManager)
            }

            describe("Get Jobs from server succeed", {
                context("when server request succeed for get jobs list", {
                    beforeEach {
                        stub(mockNetworkHandling, block: { stub in
                            when(stub.getJobs()).thenReturn(Observable.just(mockJobsList!.jobs))
                        })
                    }
                    it("calls to the mockGetJobsHandler to fetchJobList", closure: {
                        let observable = testRepository.getJobs().asObservable()
                        _ = testScheduler.start {
                            observable
                        }
                        verify(mockNetworkHandling).getJobs()
                    })

                    it("emits the jobs list to the UI", closure: {
                        let observable = testRepository.getJobs().asObservable()
                        let res = testScheduler.start {
                            observable
                        }
                        expect(res.events.count).to(equal(2))
                        let correctResult: [Recorded<Event<[JobsListDTO]>>] = [Recorded.next(200, mockJobsListDTO),
                                                                               Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })

                context("when server request failed for get jobs", {
                    beforeEach {
                        stub(mockNetworkHandling, block: { stub in
                            when(stub.getJobs()).thenReturn(Observable.error(mockError))
                        })
                    }
                    it("it completed successfully", closure: {
                        let observable = testRepository.getJobs().asObservable()
                        _ = testScheduler.start {
                            observable
                        }
                        verify(mockNetworkHandling).getJobs()
                    })
                    it("doesnt emits jobs list to the UI", closure: {
                        let observable = testRepository.getJobs().asObservable()
                        let res = testScheduler.start {
                            observable
                        }
                        expect(res.events).toNot(beNil())
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.completed(200, [JobsListDTO].self)]
                        expect(res.events).to(equal(correctResult))
                    })
                })
            })

            describe("Get Jobs list from local DB", {
                describe("when local DB request succeed for get jobs list", {
                    beforeEach {
                        stub(mockCoreDataManager, block: { stub in
                            when(stub.saveInCoreDataWith(withJobList: any())).thenReturn(Completable.empty())
                            when(stub.fetchJobList()).thenReturn(Single.just(mockJobsList!.jobs))
                        })
                    }
                    it("calls to the mockCoreDataManager to fetchJobList", closure: {
                        let observable = testRepository.getJobs().asObservable()
                        _ = testScheduler.start {
                            observable
                        }
                        verify(mockCoreDataManager).fetchJobList()
                    })

                    it("emits the jobs list to the UI", closure: {
                        let observable = testRepository.getJobs().asObservable()
                        let res = testScheduler.start {
                            observable
                        }
                        expect(res.events.count).to(equal(2))
                        let correctResult: [Recorded<Event<[JobsListDTO]>>] = [Recorded.next(200, mockJobsListDTO),
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
                        let observable = testRepository.getJobs().asObservable()
                        _ = testScheduler.start {
                            observable
                        }
                        verify(mockCoreDataManager).fetchJobList()
                    })
                    it("emits empty list to the UI", closure: {
                        let observable = testRepository.getJobs().asObservable()
                        let res = testScheduler.start {
                            observable
                        }
                        expect(res.events).toNot(beNil())
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.completed(200, [JobsListDTO].self)]
                        expect(res.events).to(equal(correctResult))
                    })
                })
            })
        }
    }
}
