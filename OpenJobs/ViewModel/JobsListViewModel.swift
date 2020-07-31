//
//  JobsListViewModel.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift

protocol JobsListDataSource: AnyObject {
    var title: Observable<String> { get }
    var segmentTitleList: [String] { get }

    var updateInfo: Observable<Bool> { get }
    var errorResult: Observable<Error> { get }
    var isLoading: Observable<Bool> { get }

    var numberOfRowsInSection: Int { get }

    func viewDidLoad()
    func updateList(withSegmentModel segmentModel: SegmentModel)
    func info(forIndex index: Int) -> JobsListDTO
    func connectedBusinessesCount(index: Int) -> Int
}

final class JobsListViewModel: JobsListDataSource {
    var title: Observable<String> { Observable.just(L10n.DashBoard.navigationTitle) }
    var segmentTitleList: [String] { ["Open Jobs", "Closed Jobs"] }
    var numberOfRowsInSection: Int { self.jobsList.count }

    let updateInfo: Observable<Bool>
    let errorResult: Observable<Error>
    let isLoading: Observable<Bool>

    private let disposeBag = DisposeBag()
    private var jobsDict: [String: [JobsListDTO]] = [:]
    private var jobsList: [JobsListDTO] = []

    private let repository: JobsListRepositoryHandling

    private let updateInfoSubject = PublishSubject<Bool>()
    private let errorResultSubject = PublishSubject<Error>()
    private let loadingSubject = BehaviorSubject<Bool>(value: true)

    init(withRepository repository: JobsListRepositoryHandling = JobsListRepository()) {
        self.repository = repository

        self.updateInfo = updateInfoSubject.asObservable()
        self.errorResult = errorResultSubject.asObservable()
        self.isLoading = loadingSubject.asObservable()
    }

    func viewDidLoad() {
        repository
            .getJobs()
            .filter { !$0.isEmpty }
            .compactMap { self.filterJobList($0) }
            .subscribe(onNext: { [weak self] result in
                self?.jobsDict = result
                self?.jobsList = result[SegmentModel.openJobs.jobStatusValue] ?? []
                self?.updateInfoSubject.onNext(true)
                self?.loadingSubject.onNext(false)

                }, onError: { [weak self] error in

                    self?.errorResultSubject.on(.next(error))
                    self?.loadingSubject.onNext(false)

            })
            .disposed(by: disposeBag)
    }

    func info(forIndex index: Int) -> JobsListDTO {
        jobsList[index]
    }

    func connectedBusinessesCount(index: Int) -> Int {
        jobsList[index].connectedBusinesses.count
    }

    func updateList(withSegmentModel segmentModel: SegmentModel) {
        jobsList = jobsDict[segmentModel.jobStatusValue] ?? []
        updateInfoSubject.onNext(true)
    }

    private func filterJobList(_ jobList: [JobsListDTO]) -> [String: [JobsListDTO]] {
        Dictionary(grouping: jobList, by: { (element: JobsListDTO) in
            element.status
        })
    }
}
