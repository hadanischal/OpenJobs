//
//  GetJobsHandler.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift

protocol JobsNetworkHandling: AnyObject {
    func getJobs() -> Observable<[JobModel]>
}

final class JobsNetworkHandler: JobsNetworkHandling {
    var resource: Resource<JobsResult> = {
        let url = URL.sourcesUrl()!
        return Resource(url: url)
    }()

    private let webService: WebServiceProtocol!

    init(withWebService webService: WebServiceProtocol = WebService()) {
        self.webService = webService
    }

    func getJobs() -> Observable<[JobModel]> {
        return self.webService.load(resource: resource)
            .map { $0.jobs }
            .asObservable()
            .retry(2)
    }
}
