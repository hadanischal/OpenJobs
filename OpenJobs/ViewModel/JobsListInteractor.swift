//
//  JobsListInteractor.swift
//  OpenJobs
//
//  Created by Nischal Hada on 19/12/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift
import CocoaLumberjack

protocol JobsListInteractorProtocol {
    func getJobs() -> Observable<[JobModel]>
}

final class JobsListInteractor: JobsListInteractorProtocol {

    private let getJobsHandler: GetJobsHandlerProtocol
    private let coreDataManager: CoreDataManagerDataSource

    init(withSourcesHandler getJobsHandler: GetJobsHandlerProtocol = GetJobsHandler(),
         withCoreDataManager coreDataManager: CoreDataManagerDataSource = CoreDataManager()) {
        self.getJobsHandler = getJobsHandler
        self.coreDataManager = coreDataManager
    }

    func getJobs() -> Observable<[JobModel]> {
        let result = Observable.concat(getJobsFromLocalDb(), getJobsListFromServer())
        return result
    }

    // MARK: - get job list from Server
    private func getJobsListFromServer() -> Observable<[JobModel]> {
        return getJobsHandler
            .getJobs()
            .filter { $0 != nil }
            .map { $0!.jobs}
            .flatMap({ jobsList -> Observable<[JobModel]> in
                return self.saveToLocalDb(withJobList: jobsList)
                    .andThen(Observable.just(jobsList))
            })
    }

    // MARK: - get job list from CoreDataManager
    private func getJobsFromLocalDb() -> Observable<[JobModel]> {
        self.coreDataManager
            .fetchJobList().catchErrorJustReturn([])
            .asObservable()
    }

    // MARK: - Save job list to CoreDataManager
    private func saveToLocalDb(withJobList jobList: [JobModel]) -> Completable {
        return self.coreDataManager.saveInCoreDataWith(withJobList: jobList)
            .catchError { _ in Completable.empty()}
    }
}
