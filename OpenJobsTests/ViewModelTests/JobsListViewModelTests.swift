//
//  JobsListViewModelTests.swift
//  OpenJobsTests
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//
// swiftlint:disable force_cast

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
        var mockJobsListRepository: MockJobsListRepositoryHandling!
        var testScheduler: TestScheduler!
        let mockJobsListDTO: [JobsListDTO]! = MockData().stubJobsListDTO()

        describe("JobsListViewModel Test") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)

                mockJobsListRepository = MockJobsListRepositoryHandling()
                stub(mockJobsListRepository, block: { stub in
                    when(stub.getJobs()).thenReturn(Observable.empty())
                })

                testViewModel = JobsListViewModel(withRepository: mockJobsListRepository)
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

            describe("Get Jobs from server succeed") {
                context("when get Jobs succeed ") {
                    beforeEach {
                        stub(mockJobsListRepository, block: { stub in
                            when(stub.getJobs()).thenReturn(Observable.just(mockJobsListDTO))
                        })

                        testScheduler.scheduleAt(300) {
                            testViewModel.viewDidLoad()
                        }
                        testViewModel.viewDidLoad()
                    }

                    it("it completed successfully", closure: {
                        verify(mockJobsListRepository).getJobs()
                    })

                    it("it sets numberOfRowsInSection correctly") {
                        expect(testViewModel.numberOfRowsInSection).to(equal(3))
                    }

                    it("emits the updateInfo to the UI") {
                        let observable = testViewModel.updateInfo.asObservable()
                        let res = testScheduler.start { observable }
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.next(300, true)]
                        expect(res.events).to(equal(correctResult))
                    }

                    it("wont emits the errorResult to the UI") {
                        let res = testScheduler.start { testViewModel.errorResult }
                        expect(res.events).toNot(beNil())
                        expect(res.events.count).to(equal(0))
                    }

                    it("emits the isLoading to the UI") {
                        let res = testScheduler.start { testViewModel.isLoading }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, false), Recorded.next(300, false)]
                        expect(res.events).to(equal(correctResult))
                    }
                }

                context("when get Jobs failed ") {
                    beforeEach {
                        stub(mockJobsListRepository, block: { stub in
                            when(stub.getJobs()).thenReturn(Observable.error(mockError))
                        })
                        testScheduler.scheduleAt(300) {
                            testViewModel.viewDidLoad()
                        }
                        testViewModel.viewDidLoad()
                    }
                    it("it completed successfully", closure: {
                        verify(mockJobsListRepository).getJobs()
                    })
                    it("it sets numbersOfIllness correctly") {
                        expect(testViewModel.numberOfRowsInSection).to(equal(0))
                    }
                    it("doesnt emits updateInfo to the UI") {
                        let observable = testViewModel.updateInfo.asObservable()
                        let res = testScheduler.start { observable }
                        expect(res.events).toNot(beNil())
                        expect(res.events.count).to(equal(0))
                    }
                    it("emits the errorResult to the UI") {
                        let res = testScheduler.start { testViewModel.errorResult.map { $0 as! MockError } }
                        expect(res.events).toNot(beNil())
                        expect(res.events.count).to(equal(1))

                        let correctResult = [Recorded.next(300, mockError)]
                        expect(res.events).to(equal(correctResult))
                    }

                    it("emits the isLoading to the UI") {
                        let res = testScheduler.start { testViewModel.isLoading }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, false), Recorded.next(300, false)]
                        expect(res.events).to(equal(correctResult))
                    }
                }
            }

            describe("When user select segment") {
                beforeEach {
                    stub(mockJobsListRepository, block: { stub in
                        when(stub.getJobs()).thenReturn(Observable.just(mockJobsListDTO))
                    })
                    testViewModel.viewDidLoad()
                }

                context("When selected SegmentModel is openJobs") {
                    var mockResponse: [JobsListDTO]!

                    beforeEach {
                        mockResponse = mockJobsListDTO.filter { $0.status == JobStatus.inProgress.rawValue }
                        testViewModel.updateList(withSegmentModel: .openJobs)
                    }

                    it("it sets numberOfRowsInSection correctly") {
                        expect(testViewModel.numberOfRowsInSection).to(equal(3))
                    }

                    it("Get Jobs info for index correctly") {
                        for item in mockResponse.enumerated() {
                            let (index, correctResult) = item
                            expect(testViewModel.info(forIndex: index)).to(equal(correctResult))
                            expect(testViewModel.connectedBusinessesCount(index: index)).to(equal(correctResult.connectedBusinesses.count))
                        }
                    }
                }

                context("When selected SegmentModel is closedJobs") {
                    var mockResponse: [JobsListDTO]!

                    beforeEach {
                        mockResponse = mockJobsListDTO.filter { $0.status == JobStatus.closed.rawValue }
                        testViewModel.updateList(withSegmentModel: .closedJobs)
                    }

                    it("it sets numberOfRowsInSection correctly") {
                        expect(testViewModel.numberOfRowsInSection).to(equal(1))
                    }

                    it("Get Jobs info for index correctly") {
                        for item in mockResponse.enumerated() {
                            let (index, correctResult) = item
                            expect(testViewModel.info(forIndex: index)).to(equal(correctResult))
                            expect(testViewModel.connectedBusinessesCount(index: index)).to(equal(correctResult.connectedBusinesses.count))
                        }
                    }
                }
            }
        }
    }
}
