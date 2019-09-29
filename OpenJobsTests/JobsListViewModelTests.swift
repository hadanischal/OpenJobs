//
//  JobsListViewModelTests.swift
//  OpenJobsTests
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//
// swiftlint:disable function_body_length

import XCTest
import Quick
import Nimble
import Cuckoo
import RxTest
import RxBlocking
import RxSwift

@testable import OpenJobs

class JobsListViewModelTests: QuickSpec {

    override func spec() {
        var testViewModel: JobsListViewModel!
        var mockGetJobsHandler: MockGetJobsHandlerProtocol!
        var testScheduler: TestScheduler!
        let mockJobsList = MockData().stubJobsList()

        describe("JobsListViewModel") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockGetJobsHandler = MockGetJobsHandlerProtocol()
                stub(mockGetJobsHandler, block: { stub in
                    when(stub.getJobs()).thenReturn(Observable.empty())
                })
                testViewModel = JobsListViewModel(withSourcesHandler: mockGetJobsHandler)
            }

            it("sets the titleText correctly", closure: {
                let res = testScheduler.start { testViewModel.title.asObservable() }
                expect(res.events.count).to(equal(2))
                let correctResult = [Recorded.next(200, "Select Job"),
                                     Recorded.completed(200)]
                expect(res.events).to(equal(correctResult))
            })

            describe("sets businessesStatus correctly", {
                context("When ConnectedBusiness is greater then zero", {
                    var businessesStatus: String!
                    beforeEach {
                        let connectedBusinesses =  MockData().jobsOpen[0].connectedBusinesses
                        businessesStatus =  testViewModel.businessesStatus(connectedBusinesses)
                    }
                    it("sets the businessesStatus correctly", closure: {
                        expect(businessesStatus).to(equal("You have hired 4 businesses"))
                    })
                })

                context("When ConnectedBusiness is zero", {
                    var businessesStatus: String!
                    beforeEach {
                        let connectedBusinesses =  MockData().jobsOpen.last?.connectedBusinesses
                        businessesStatus =  testViewModel.businessesStatus(connectedBusinesses)
                    }
                    it("sets the businessesStatus correctly", closure: {
                        expect(businessesStatus).to(equal("connecting you with businesses"))
                    })
                })
            })

            describe("Get Jobs from server succeed", {

                context("when server request succeed for get jobs list", {
                    beforeEach {
                        stub(mockGetJobsHandler, block: { stub in
                            when(stub.getJobs()).thenReturn(Observable.just(mockJobsList))
                        })
                        testViewModel.getJobsList()
                    }
                    it("it completed successfully", closure: {
                        verify(mockGetJobsHandler).getJobs()
                    })

                    context("When server request get succeed", {
                        beforeEach {
                            testScheduler.scheduleAt(300, action: {
                                testViewModel.getJobsList()
                            })
                        }

                        it("emits the jobs list to the UI", closure: {
                            let observable = testViewModel.jobsList.asObservable()
                            let res = testScheduler.start {
                                observable
                            }
                            expect(res.events.count).to(equal(1))
                            let correctResult = [Recorded.next(300, MockData().jobsOpen)]
                            expect(res.events).to(equal(correctResult))
                        })
                    })
                })

                describe("When user select segment", {
                    beforeEach {
                        stub(mockGetJobsHandler, block: { stub in
                            when(stub.getJobs()).thenReturn(Observable.just(mockJobsList))
                        })
                        testViewModel.getJobsList()
                    }
                    it("it completed successfully", closure: {
                        verify(mockGetJobsHandler).getJobs()
                    })

                    context("When SegmentModel is openJobs", {
                        beforeEach {
                            //make api request
                            testScheduler.scheduleAt(300, action: {
                                testViewModel.getJobsList()
                            })

                            //User Select segment openJobs after API request is complete
                            testScheduler.scheduleAt(500, action: {
                                testViewModel.updateList(withSegmentModel: SegmentModel.openJobs)
                            })
                        }

                        it("emits the jobs list to the UI", closure: {
                            let observable = testViewModel.jobsList.asObservable()
                            let res = testScheduler.start {
                                observable
                            }
                            expect(res.events.count).to(equal(2))
                            let correctResult = [Recorded.next(300, MockData().jobsOpen),
                                                 Recorded.next(500, MockData().jobsOpen)]
                            expect(res.events).to(equal(correctResult))
                        })
                    })

                    context("When SegmentModel is closedJobs", {
                        beforeEach {
                            //make api request
                            testScheduler.scheduleAt(300, action: {
                                testViewModel.getJobsList()
                            })

                            //User Select segment closedJobs after API request is complete
                            testScheduler.scheduleAt(500, action: {
                                testViewModel.updateList(withSegmentModel: SegmentModel.closedJobs)
                            })
                        }

                        it("emits the jobs list to the UI", closure: {
                            let observable = testViewModel.jobsList.asObservable()
                            let res = testScheduler.start {
                                observable
                            }
                            expect(res.events.count).to(equal(2))
                            let correctResult = [Recorded.next(300, MockData().jobsOpen),
                                                 Recorded.next(500, MockData().jobsClosed)]
                            expect(res.events).to(equal(correctResult))
                        })
                    })
                })
            })

            context("when server request failed for get jobs", {
                beforeEach {
                    stub(mockGetJobsHandler, block: { stub in
                        when(stub.getJobs()).thenReturn(Observable.error(mockError))
                    })
                    testViewModel.getJobsList()
                }
                it("it completed successfully", closure: {
                    verify(mockGetJobsHandler).getJobs()
                })
                context("doesnt emits jobs list to the UI", {
                    beforeEach {
                        testScheduler.scheduleAt(300, action: {
                            testViewModel.getJobsList()
                        })
                    }
                    it("doesnt emits jobs list to the UI", closure: {
                        let observable = testViewModel.jobsList.asObservable()
                        let res = testScheduler.start {
                            observable
                        }
                        expect(res.events).toNot(beNil())
                        expect(res.events.count).to(equal(0))
                    })
                })

            })
        }
    }
}
