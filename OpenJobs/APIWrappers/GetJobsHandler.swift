//
//  GetJobsHandler.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift

final class GetJobsHandler: GetJobsHandlerProtocol {
    var resource: Resource<JobsList> = {
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
