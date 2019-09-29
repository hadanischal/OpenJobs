//
//  CoreDataManagerDataSource.swift
//  OpenJobs
//
//  Created by Nischal Hada on 29/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import RxSwift

protocol CoreDataManagerDataSource {
    func saveInCoreDataWith(withJobList jobList: [JobModel]) -> Completable
    func fetchJobList() -> Single<[JobModel]>
}
