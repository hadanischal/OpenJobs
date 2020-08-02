//
//  MockData.swift
//  OpenJobsTests
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

@testable import OpenJobs
import XCTest

class MockData {
    func stubJobsList() -> JobsResult? {
        guard let data = self.readJson(forResource: "jobs") else {
            XCTAssert(false, "Can't get data from jobs.json")
            return nil
        }

        let decoder = JSONDecoder()
        if let result = try? decoder.decode(JobsResult.self, from: data) {
            return result
        } else {
            XCTAssert(false, "Unable to parse ArticlesList results")
            return nil
        }
    }

    func stubJobsListDTO() -> [JobsListDTO] {
        let jobsListDTO = self.stubJobsList().map(\.jobs).map { list -> [JobsListDTO] in
            list.map { JobsListDTO($0) }
        }
        return jobsListDTO ?? []
    }

    var jobsOpen: [JobsListDTO] {
        return filterJobList()[JobStatus.inProgress.rawValue.lowercased()] ?? []
    }

    var jobsClosed: [JobsListDTO] {
        return filterJobList()[JobStatus.closed.rawValue.lowercased()] ?? []
    }

    func readJson(forResource fileName: String) -> Data? {
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

    private func filterJobList() -> [String: [JobsListDTO]] {
       let jobList = self.stubJobsListDTO()

        let dictionary = Dictionary(grouping: jobList, by: { (element: JobsListDTO) in
            element.status.lowercased()
        })
        return dictionary
    }
}
