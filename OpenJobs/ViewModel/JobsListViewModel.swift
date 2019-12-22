//
//  JobsListViewModel.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift
import CocoaLumberjack

protocol JobsListDataSource {
    func viewDidLoad()
    func updateList(withSegmentModel segmentModel: SegmentModel)
    var jobsList: Observable<[JobModel]> { get }
    var title: Observable<String> { get }
    func businessesStatus(_ connectedBusiness: [ConnectedBusinessModel]?) -> String
}

enum JobType: String {
    case inProgress = "In Progress"
    case closed = "Closed"
}

final class JobsListViewModel: JobsListDataSource {

    //Output
    var jobsList: Observable<[JobModel]>

    //input
    private let jobsListInteractor: JobsListInteractorProtocol

    private var jobsOpenAndClosed: [JobModel] = []
    private var jobsOpen: [JobModel] = []
    private var jobsClosed: [JobModel] = []

    private let jobsListSubject = PublishSubject<[JobModel]>()
    private let disposeBag = DisposeBag()

    init(withJobsListInteractor jobsListInteractor: JobsListInteractorProtocol = JobsListInteractor()) {
        self.jobsListInteractor = jobsListInteractor
        self.jobsList = jobsListSubject.asObserver()
    }

    var title: Observable<String> {
        return Observable.just(L10n.DashBoard.navigationTitle)
    }

    func businessesStatus(_ connectedBusiness: [ConnectedBusinessModel]?) -> String {
        if let businessList = connectedBusiness,
            !businessList.isEmpty {
            return L10n.DashBoard.businessCountDescription(businessList.count)
        }
        return L10n.DashBoard.businessCountNill
    }

    func viewDidLoad() {
        self.getJobsList()
    }

    private func getJobsList() {

        self.jobsListInteractor
            .getJobs()
            .filter { !$0.isEmpty }
            .flatMap { [weak self] list -> Observable<()> in
                guard let self = self else { return Observable.empty()}

                let filterJobList = self.filterJobList(withJobList: list)
                return self.updateJobList(withValue: filterJobList)
                    .andThen(Observable.just(()))
        }.subscribe(onNext: { _ in
            self.updateList(withSegmentModel: .openJobs)
        }).disposed(by: disposeBag)
    }

    private func filterJobList(withJobList jobList: [JobModel]) -> [String: [JobModel]] {
        let dictionary = Dictionary(grouping: jobList, by: { (element: JobModel) in
            return element.status.lowercased()
        })
        return dictionary
    }

    private func updateJobList(withValue result: [String: [JobModel]]) -> Completable {

        return Completable.create { completable in
            let valueInProgress = result[JobType.inProgress.rawValue.lowercased()]
            let valueClosed = result[JobType.closed.rawValue.lowercased()]

            guard (valueInProgress != nil) || (valueClosed != nil) else {
                completable(.error(RxError.noElements))
                return Disposables.create {}
            }

            self.jobsOpen = valueInProgress ?? []
            self.jobsClosed = valueClosed ?? []

            completable(.completed)
            return Disposables.create {}
        }
    }

    func updateList(withSegmentModel segmentModel: SegmentModel) {
        switch segmentModel {
        case .openJobs:
            jobsListSubject.onNext(jobsOpen)
        case .closedJobs:
            jobsListSubject.onNext(jobsClosed)
        }
    }
}
