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
    func getJobsList()
    func updateList(withSegmentModel segmentModel: SegmentModel)
    var jobsList: Observable<[JobModel]> { get }
    var title: Observable<String> { get }
}

enum JobType: String {
    case inProgress = "In Progress"
    case closed = "Closed"
}

class JobsListViewModel: JobsListDataSource {

    //Output
    var jobsList: Observable<[JobModel]>

    //input
    private let getJobsHandler: GetJobsHandlerProtocol!

    private var jobsOpen: [JobModel] = []
    private var jobsClosed: [JobModel] = []

    private let jobsListSubject = PublishSubject<[JobModel]>()
    private let disposeBag = DisposeBag()

    init(withSourcesHandler getJobsHandler: GetJobsHandlerProtocol = GetJobsHandler()) {
        self.getJobsHandler = getJobsHandler
        self.jobsList = jobsListSubject.asObserver()
    }

    var title: Observable<String> {
        return Observable.just("Select Job")
    }

    func getJobsList() {
        getJobsHandler
            .getJobs()
            .flatMap { [weak self] result -> Observable<[String: [JobModel]]> in
                if let list = result?.jobs {
                    return self?.filterJobList(withJobList: list) ?? Observable.error(RxError.unknown)
                }
                return Observable.error(RxError.unknown)
            }.flatMap { [weak self] result -> Completable in
                return self?.updateJobList(withValue: result) ?? Completable.error(RxError.unknown)
            }.subscribe(onNext: { _ in
                DDLogInfo("onNext")

            }, onError: { error in
                DDLogError("onError: \(error)")

            }, onCompleted: { [weak self] in
                DDLogInfo("onCompleted")
                self?.jobsListSubject.onNext(self?.jobsOpen ?? [])

            }).disposed(by: disposeBag)

    }

    func updateList(withSegmentModel segmentModel: SegmentModel) {
        switch segmentModel {
        case .openJobs:
            jobsListSubject.onNext(jobsOpen)
        case .closedJobs:
            jobsListSubject.onNext(jobsClosed)
        }
    }

    private func filterJobList(withJobList jobList: [JobModel]) -> Observable<[String: [JobModel]]> {
        return Observable.create { observer in
            let dictionary = Dictionary(grouping: jobList, by: { (element: JobModel) in
                return element.status.lowercased()
            })
            observer.on(.next(dictionary))
            observer.on(.completed)
            return Disposables.create()
        }
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

}
