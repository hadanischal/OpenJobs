//
//  CoreDataManager.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation
import CoreData
import CocoaLumberjack
import RxSwift

final class CoreDataManager: CoreDataManagerDataSource {
    private let disposeBag = DisposeBag()

    init() {
    }

    //Returns the current Persistent Container for CoreData
    private var managedContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }

    func saveInCoreDataWith(withJobList jobList: [JobModel]) -> Completable {
        return clearData()
        .andThen(saveCoreData(jobList))
    }

    private func saveCoreData(_ jobList: [JobModel]) -> Completable {
        return Completable.create { completable in
            _ = jobList.map {self.createJobEntityFrom(jobInfo: $0)}
            do {
                try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
                completable(.completed)
                return Disposables.create {}

            } catch let error {
                DDLogError("ERROR saveCoreData : \(error)")
                completable(.error(RxError.noElements))
                return Disposables.create {}
            }

        }
    }

    private func createJobEntityFrom(jobInfo: JobModel) -> NSManagedObject? {
        let context = self.managedContext
        if let jobsEntity = NSEntityDescription.insertNewObject(forEntityName: "Jobs", into: context) as? Jobs {
            jobsEntity.jobId = jobInfo.jobID
            jobsEntity.category = jobInfo.category
            jobsEntity.postedDate = jobInfo.postedDate
            jobsEntity.status = jobInfo.status
            jobsEntity.detailsLink = jobInfo.detailsLink

            if let businesses = jobInfo.connectedBusinesses {
                let businessEntity = jobsEntity.mutableSetValue(forKey: "connectedBusinesses")
                let connectedBusinesses = businesses.map { self.createConnectedBusinessFrom(businessModel: $0)
                }
                businessEntity.addObjects(from: connectedBusinesses as [Any])
            }

            return jobsEntity
        }
        return nil
    }

    private func createConnectedBusinessFrom(businessModel: ConnectedBusinessModel) -> NSManagedObject? {
        let context = self.managedContext
        if let entity = NSEntityDescription.insertNewObject(forEntityName: "ConnectedBusinesses", into: context) as? ConnectedBusinesses {
            entity.businessId = businessModel.businessID ?? 0
            entity.thumbnail = businessModel.thumbnail
            entity.isHired = businessModel.isHired ?? false
            return entity
        }
        return nil
    }

    private func clearData() -> Completable {
        return Completable.create { completable in
            do {
                let context = self.managedContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Jobs.self))
                do {
                    let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                    _ = objects.map {$0.map {context.delete($0)}}
                    CoreDataStack.sharedInstance.saveContext()
                    completable(.completed)
                    return Disposables.create {}

                } catch let error {
                    DDLogInfo("ERROR DELETING : \(error)")
                    completable(.error(error))
                    return Disposables.create {}
                }
            }
        }
    }

    func fetchJobList() -> Single<[JobModel]> {
        return Single<[JobModel]>.create { single in
            let fetchRequest = NSFetchRequest<Jobs>(entityName: "Jobs")
            var allJobModel = [JobModel]()
            do {
                let result = try self.managedContext.fetch(fetchRequest)
                DDLogInfo("result: \(result)")
                let jobModel = result.map({ (data) -> JobModel in
                    return JobModel(withJobs: data)
                })
                allJobModel = jobModel.reversed()
                single(.success(allJobModel))
                return Disposables.create {}
            } catch let error {
                DDLogInfo("ERROR: \(error)")
                single(.error(error))
                return Disposables.create {}
            }
        }
    }
}
