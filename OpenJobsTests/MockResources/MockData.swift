//
//  MockData.swift
//  OpenJobsTests
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import XCTest
@testable import OpenJobs

class MockData {

    func stubJobsList() -> JobsList? {

        guard let data = self.readJson(forResource: "jobs") else {
            XCTAssert(false, "Can't get data from jobs.json")
            return nil
        }

        let decoder = JSONDecoder()
        if let result = try? decoder.decode(JobsList.self, from: data) {
            return result
        } else {
            XCTAssert(false, "Unable to parse ArticlesList results")
            return nil
        }
    }

    var jobsOpen: [JobModel] {
        return filterJobList()[JobStatus.inProgress.rawValue.lowercased()] ?? []
    }

    var jobsClosed: [JobModel] {
        return filterJobList()[JobStatus.closed.rawValue.lowercased()] ?? []
    }

    func readJson(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing file: \(fileName).json")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            XCTFail("unable to read json")
            return nil
        }
    }

    private func filterJobList() -> [String: [JobModel]] {

        guard let jobList  = self.stubJobsList() else {
            XCTAssert(false, "Can't get job list from jobs.json")
            return ["": []]
        }

        let dictionary = Dictionary(grouping: jobList.jobs, by: { (element: JobModel) in
            return element.status.lowercased()
        })
        return dictionary
    }
}
