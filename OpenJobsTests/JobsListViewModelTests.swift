//
//  JobsListViewModelTests.swift
//  OpenJobsTests
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//
// swiftlint:disable function_body_length

import Cuckoo
import Nimble
import Quick
import RxBlocking
import RxSwift
import RxTest
import XCTest

@testable import OpenJobs

class JobsListViewModelTests: QuickSpec {
    override func spec() {
        var testViewModel: JobsListViewModel!
        var mockJobsListInteractor: MockJobsListInteractorProtocol!
        var testScheduler: TestScheduler!
        let mockJobsList = MockData().stubJobsList()!.jobs

        describe("JobsListViewModel") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)

                mockJobsListInteractor = MockJobsListInteractorProtocol()
                stub(mockJobsListInteractor, block: { stub in
                    when(stub.getJobs()).thenReturn(Observable.empty())
                })

                testViewModel = JobsListViewModel(withJobsListInteractor: mockJobsListInteractor)
            }

            it("sets the titleText correctly", closure: {
                let res = testScheduler.start { testViewModel.title.asObservable() }
                expect(res.events.count).to(equal(2))
                let correctResult = [Recorded.next(200, "Select Job"),
                                     Recorded.completed(200)]
                expect(res.events).to(equal(correctResult))
            })

            it("sets the segmentTitleList correctly", closure: {
                let correctResult = ["Open Jobs", "Closed Jobs"]
                expect(testViewModel.segmentTitleList).to(equal(correctResult))
                expect(testViewModel.segmentTitleList.count).to(equal(2))
            })

            describe("sets businessesStatus correctly", {
                context("When ConnectedBusiness is greater then zero", {
                    var businessesStatus: String!
                    beforeEach {
                        let connectedBusinesses = MockData().jobsOpen[0].connectedBusinesses
                        businessesStatus = testViewModel.businessesStatus(connectedBusinesses)
                    }
                    it("sets the businessesStatus correctly", closure: {
                        expect(businessesStatus).to(equal("You have hired 4 businesses"))
                    })
                })

                context("When ConnectedBusiness is zero", {
                    var businessesStatus: String!
                    beforeEach {
                        let connectedBusinesses = MockData().jobsOpen.last?.connectedBusinesses
                        businessesStatus = testViewModel.businessesStatus(connectedBusinesses)
                    }
                    it("sets the businessesStatus correctly", closure: {
                        expect(businessesStatus).to(equal("connecting you with businesses"))
                    })
                })
            })

            describe("Get Jobs from server succeed", {
                context("when server request succeed for get jobs list", {
                    beforeEach {
                        stub(mockJobsListInteractor, block: { stub in
                            when(stub.getJobs()).thenReturn(Observable.just(mockJobsList))
                        })
                        testViewModel.viewDidLoad()
                    }
                    it("it completed successfully", closure: {
                        verify(mockJobsListInteractor).getJobs()
                    })

                    context("When server request get succeed", {
                        beforeEach {
                            testScheduler.scheduleAt(300, action: {
                                testViewModel.viewDidLoad()
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
                        stub(mockJobsListInteractor, block: { stub in
                            when(stub.getJobs()).thenReturn(Observable.just(mockJobsList))
                        })
                        testViewModel.viewDidLoad()
                    }
                    it("it completed successfully", closure: {
                        verify(mockJobsListInteractor).getJobs()
                    })

                    context("When SegmentModel is openJobs", {
                        beforeEach {
                            // Make api request
                            testScheduler.scheduleAt(300, action: {
                                testViewModel.viewDidLoad()
                            })

                            // User Select segment openJobs after API request is complete
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
                            // Make api request
                            testScheduler.scheduleAt(300, action: {
                                testViewModel.viewDidLoad()
                            })

                            // User Select segment closedJobs after API request is complete
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
                    stub(mockJobsListInteractor, block: { stub in
                        when(stub.getJobs()).thenReturn(Observable.error(mockError))
                    })
                    testViewModel.viewDidLoad()
                }
                it("it completed successfully", closure: {
                    verify(mockJobsListInteractor).getJobs()
                })
                context("doesnt emits jobs list to the UI", {
                    beforeEach {
                        testScheduler.scheduleAt(300, action: {
                            testViewModel.viewDidLoad()
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
