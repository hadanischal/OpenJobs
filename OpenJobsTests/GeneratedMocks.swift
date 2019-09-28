// MARK: - Mocks generated from file: OpenJobs/APIWrappers/GetJobsHandlerProtocol.swift at 2019-09-28 04:19:20 +0000

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


// MARK: - Mocks generated from file: OpenJobs/Networking/WebServiceProtocol.swift at 2019-09-28 04:19:20 +0000

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

