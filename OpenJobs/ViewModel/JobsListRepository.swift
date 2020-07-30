//
//  JobsListInteractor.swift
//  OpenJobs
//
//  Created by Nischal Hada on 19/12/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift

protocol JobsListRepositoryHandling: AnyObject {
    func getJobs() -> Observable<[JobsListDTO]>
}

final class JobsListRepository: JobsListRepositoryHandling {
    private let getJobsHandler: JobsNetworkHandling
    private let coreDataManager: CoreDataManagerHandling

    init(withSourcesHandler getJobsHandler: JobsNetworkHandling = JobsNetworkHandler(),
         withCoreDataManager coreDataManager: CoreDataManagerHandling = CoreDataManagerHandler()) {
        self.getJobsHandler = getJobsHandler
        self.coreDataManager = coreDataManager
    }

    func getJobs() -> Observable<[JobsListDTO]> {
        let result = Observable.concat(getJobsFromLocalDb(), getJobsListFromServer())
        return result.compactMap { list -> [JobsListDTO] in
            list.map { JobsListDTO($0) }
        }
    }

    // MARK: - get job list from Server

    private func getJobsListFromServer() -> Observable<[JobModel]> {
        return getJobsHandler
            .getJobs()
            .catchErrorJustReturn([])
            .filter { !$0.isEmpty }
            .flatMap { [weak self] jobsList -> Observable<[JobModel]> in
                (self?.saveToLocalDb(withJobList: jobsList) ?? Completable.empty())
                    .andThen(Observable.just(jobsList))
        }
    }

    // MARK: - get job list from CoreDataManager

    private func getJobsFromLocalDb() -> Observable<[JobModel]> {
        self.coreDataManager
            .fetchJobList()
            .catchErrorJustReturn([])
            .filter { !$0.isEmpty }
            .asObservable()
    }

    // MARK: - Save job list to CoreDataManager

    private func saveToLocalDb(withJobList jobList: [JobModel]) -> Completable {
        return self.coreDataManager.saveInCoreDataWith(withJobList: jobList)
            .catchError { _ in Completable.empty() }
    }
}
