//
//  CoreDataManager.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import CocoaLumberjack
import CoreData
import Foundation
import RxSwift

protocol CoreDataManagerHandling {
    func saveInCoreDataWith(withJobList jobList: [JobModel]) -> Completable
    func fetchJobList() -> Single<[JobModel]>
}

final class CoreDataManagerHandler: CoreDataManagerHandling {
    private let disposeBag = DisposeBag()

    // Returns the current Persistent Container for CoreData
    private lazy var managedContext: NSManagedObjectContext = {
        CoreDataStack.sharedInstance.persistentContainer.viewContext
    }()

    private lazy var coreDataStack: CoreDataStack = {
        CoreDataStack.sharedInstance
    }()

    func saveInCoreDataWith(withJobList jobList: [JobModel]) -> Completable {
        return clearData()
        .andThen(saveCoreData(jobList))
    }

    private func saveCoreData(_ jobList: [JobModel]) -> Completable {
        return Completable.create { completable in
            _ = jobList.map { self.createJobEntityFrom(jobInfo: $0) }
            do {
                try self.managedContext.save()
                completable(.completed)
                return Disposables.create {}

            } catch {
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
            entity.businessId = businessModel.businessId ?? 0
            entity.thumbnail = businessModel.thumbnail
            entity.isHired = businessModel.isHired ?? false
            return entity
        }
        return nil
    }

     func clearData() -> Completable {
        return Completable.create { completable in
            do {
                let context = self.managedContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Jobs.self))
                do {
                    let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
                    _ = objects.map { $0.map { context.delete($0) } }
                   self.coreDataStack.saveContext()
                    completable(.completed)
                    return Disposables.create {}

                } catch {
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
                    JobModel(withJobs: data)
                })
                allJobModel = jobModel.reversed()
                single(.success(allJobModel))
                return Disposables.create {}
            } catch {
                DDLogInfo("ERROR: \(error)")
                single(.error(error))
                return Disposables.create {}
            }
        }
    }
}
