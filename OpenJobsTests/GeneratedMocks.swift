// MARK: - Mocks generated from file: OpenJobs/APIWrappers/GetJobsHandlerProtocol.swift at 2019-10-08 01:03:53 +0000

//
//  GetJobsHandlerProtocol.swift
//  OpenJobs
//
//  Created by Nischal Hada on 28/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Cuckoo
@testable import OpenJobs

import RxSwift


 class MockGetJobsHandlerProtocol: GetJobsHandlerProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = GetJobsHandlerProtocol
    
     typealias Stubbing = __StubbingProxy_GetJobsHandlerProtocol
     typealias Verification = __VerificationProxy_GetJobsHandlerProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GetJobsHandlerProtocol?

     func enableDefaultImplementation(_ stub: GetJobsHandlerProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getJobs() -> Observable<JobsList?> {
        
    return cuckoo_manager.call("getJobs() -> Observable<JobsList?>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getJobs())
        
    }
    

	 struct __StubbingProxy_GetJobsHandlerProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getJobs() -> Cuckoo.ProtocolStubFunction<(), Observable<JobsList?>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGetJobsHandlerProtocol.self, method: "getJobs() -> Observable<JobsList?>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GetJobsHandlerProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getJobs() -> Cuckoo.__DoNotUse<(), Observable<JobsList?>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getJobs() -> Observable<JobsList?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GetJobsHandlerProtocolStub: GetJobsHandlerProtocol {
    

    

    
     func getJobs() -> Observable<JobsList?>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<JobsList?>).self)
    }
    
}


// MARK: - Mocks generated from file: OpenJobs/CoreDataManager/CoreDataManagerDataSource.swift at 2019-10-08 01:03:53 +0000

//
//  CoreDataManagerDataSource.swift
//  OpenJobs
//
//  Created by Nischal Hada on 29/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Cuckoo
@testable import OpenJobs

import RxSwift


 class MockCoreDataManagerDataSource: CoreDataManagerDataSource, Cuckoo.ProtocolMock {
    
     typealias MocksType = CoreDataManagerDataSource
    
     typealias Stubbing = __StubbingProxy_CoreDataManagerDataSource
     typealias Verification = __VerificationProxy_CoreDataManagerDataSource

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CoreDataManagerDataSource?

     func enableDefaultImplementation(_ stub: CoreDataManagerDataSource) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func saveInCoreDataWith(withJobList jobList: [JobModel]) -> Completable {
        
    return cuckoo_manager.call("saveInCoreDataWith(withJobList: [JobModel]) -> Completable",
            parameters: (jobList),
            escapingParameters: (jobList),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveInCoreDataWith(withJobList: jobList))
        
    }
    
    
    
     func fetchJobList() -> Single<[JobModel]> {
        
    return cuckoo_manager.call("fetchJobList() -> Single<[JobModel]>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.fetchJobList())
        
    }
    

	 struct __StubbingProxy_CoreDataManagerDataSource: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func saveInCoreDataWith<M1: Cuckoo.Matchable>(withJobList jobList: M1) -> Cuckoo.ProtocolStubFunction<([JobModel]), Completable> where M1.MatchedType == [JobModel] {
	        let matchers: [Cuckoo.ParameterMatcher<([JobModel])>] = [wrap(matchable: jobList) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCoreDataManagerDataSource.self, method: "saveInCoreDataWith(withJobList: [JobModel]) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func fetchJobList() -> Cuckoo.ProtocolStubFunction<(), Single<[JobModel]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockCoreDataManagerDataSource.self, method: "fetchJobList() -> Single<[JobModel]>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_CoreDataManagerDataSource: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func saveInCoreDataWith<M1: Cuckoo.Matchable>(withJobList jobList: M1) -> Cuckoo.__DoNotUse<([JobModel]), Completable> where M1.MatchedType == [JobModel] {
	        let matchers: [Cuckoo.ParameterMatcher<([JobModel])>] = [wrap(matchable: jobList) { $0 }]
	        return cuckoo_manager.verify("saveInCoreDataWith(withJobList: [JobModel]) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func fetchJobList() -> Cuckoo.__DoNotUse<(), Single<[JobModel]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("fetchJobList() -> Single<[JobModel]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class CoreDataManagerDataSourceStub: CoreDataManagerDataSource {
    

    

    
     func saveInCoreDataWith(withJobList jobList: [JobModel]) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func fetchJobList() -> Single<[JobModel]>  {
        return DefaultValueRegistry.defaultValue(for: (Single<[JobModel]>).self)
    }
    
}


// MARK: - Mocks generated from file: OpenJobs/Networking/WebServiceProtocol.swift at 2019-10-08 01:03:53 +0000

//
//  WebServiceProtocol.swift
//  OpenJobs
//
//  Created by Nischal Hada on 26/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Cuckoo
@testable import OpenJobs

import RxSwift


 class MockWebServiceProtocol: WebServiceProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = WebServiceProtocol
    
     typealias Stubbing = __StubbingProxy_WebServiceProtocol
     typealias Verification = __VerificationProxy_WebServiceProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: WebServiceProtocol?

     func enableDefaultImplementation(_ stub: WebServiceProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
        
    return cuckoo_manager.call("load(resource: Resource<T>) -> Observable<T>",
            parameters: (resource),
            escapingParameters: (resource),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.load(resource: resource))
        
    }
    

	 struct __StubbingProxy_WebServiceProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func load<M1: Cuckoo.Matchable, T: Decodable>(resource: M1) -> Cuckoo.ProtocolStubFunction<(Resource<T>), Observable<T>> where M1.MatchedType == Resource<T> {
	        let matchers: [Cuckoo.ParameterMatcher<(Resource<T>)>] = [wrap(matchable: resource) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWebServiceProtocol.self, method: "load(resource: Resource<T>) -> Observable<T>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WebServiceProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func load<M1: Cuckoo.Matchable, T: Decodable>(resource: M1) -> Cuckoo.__DoNotUse<(Resource<T>), Observable<T>> where M1.MatchedType == Resource<T> {
	        let matchers: [Cuckoo.ParameterMatcher<(Resource<T>)>] = [wrap(matchable: resource) { $0 }]
	        return cuckoo_manager.verify("load(resource: Resource<T>) -> Observable<T>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WebServiceProtocolStub: WebServiceProtocol {
    

    

    
     func load<T: Decodable>(resource: Resource<T>) -> Observable<T>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<T>).self)
    }
    
}

