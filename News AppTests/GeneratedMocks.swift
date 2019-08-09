// MARK: - Mocks generated from file: News App/Delegates/ButtonPressDelegate.swift at 2019-08-09 08:47:46 +0000

//
//  ButtonPressDelegate.swift
//  News App
//
//  Created by Matej Hetzel on 22/07/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Cuckoo
@testable import News_App

import UIKit


 class MockButtonPressDelegate: ButtonPressDelegate, Cuckoo.ProtocolMock {
    
     typealias MocksType = ButtonPressDelegate
    
     typealias Stubbing = __StubbingProxy_ButtonPressDelegate
     typealias Verification = __VerificationProxy_ButtonPressDelegate

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ButtonPressDelegate?

     func enableDefaultImplementation(_ stub: ButtonPressDelegate) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func buttonIsPressed(new: Article)  {
        
    return cuckoo_manager.call("buttonIsPressed(new: Article)",
            parameters: (new),
            escapingParameters: (new),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.buttonIsPressed(new: new))
        
    }
    

	 struct __StubbingProxy_ButtonPressDelegate: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func buttonIsPressed<M1: Cuckoo.Matchable>(new: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Article)> where M1.MatchedType == Article {
	        let matchers: [Cuckoo.ParameterMatcher<(Article)>] = [wrap(matchable: new) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockButtonPressDelegate.self, method: "buttonIsPressed(new: Article)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ButtonPressDelegate: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func buttonIsPressed<M1: Cuckoo.Matchable>(new: M1) -> Cuckoo.__DoNotUse<(Article), Void> where M1.MatchedType == Article {
	        let matchers: [Cuckoo.ParameterMatcher<(Article)>] = [wrap(matchable: new) { $0 }]
	        return cuckoo_manager.verify("buttonIsPressed(new: Article)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ButtonPressDelegateStub: ButtonPressDelegate {
    

    

    
     func buttonIsPressed(new: Article)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: News App/Delegates/DetailsNavigationDelegate.swift at 2019-08-09 08:47:46 +0000

//
//  DetailsNavigationDelegate.swift
//  News App
//
//  Created by Matej Hetzel on 01/08/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Cuckoo
@testable import News_App

import Foundation
import UIKit


 class MockDetailsNavigationDelegate: DetailsNavigationDelegate, Cuckoo.ProtocolMock {
    
     typealias MocksType = DetailsNavigationDelegate
    
     typealias Stubbing = __StubbingProxy_DetailsNavigationDelegate
     typealias Verification = __VerificationProxy_DetailsNavigationDelegate

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DetailsNavigationDelegate?

     func enableDefaultImplementation(_ stub: DetailsNavigationDelegate) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func openDetailsView(news: Article)  {
        
    return cuckoo_manager.call("openDetailsView(news: Article)",
            parameters: (news),
            escapingParameters: (news),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.openDetailsView(news: news))
        
    }
    

	 struct __StubbingProxy_DetailsNavigationDelegate: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func openDetailsView<M1: Cuckoo.Matchable>(news: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Article)> where M1.MatchedType == Article {
	        let matchers: [Cuckoo.ParameterMatcher<(Article)>] = [wrap(matchable: news) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDetailsNavigationDelegate.self, method: "openDetailsView(news: Article)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_DetailsNavigationDelegate: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func openDetailsView<M1: Cuckoo.Matchable>(news: M1) -> Cuckoo.__DoNotUse<(Article), Void> where M1.MatchedType == Article {
	        let matchers: [Cuckoo.ParameterMatcher<(Article)>] = [wrap(matchable: news) { $0 }]
	        return cuckoo_manager.verify("openDetailsView(news: Article)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DetailsNavigationDelegateStub: DetailsNavigationDelegate {
    

    

    
     func openDetailsView(news: Article)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: News App/Delegates/FavoriteDelegate.swift at 2019-08-09 08:47:46 +0000

//
//  FavoriteDelegate.swift
//  News App
//
//  Created by Matej Hetzel on 19/07/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Cuckoo
@testable import News_App

import UIKit


 class MockFavoriteDelegate: FavoriteDelegate, Cuckoo.ProtocolMock {
    
     typealias MocksType = FavoriteDelegate
    
     typealias Stubbing = __StubbingProxy_FavoriteDelegate
     typealias Verification = __VerificationProxy_FavoriteDelegate

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FavoriteDelegate?

     func enableDefaultImplementation(_ stub: FavoriteDelegate) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func changeFavoriteState(news: Article)  {
        
    return cuckoo_manager.call("changeFavoriteState(news: Article)",
            parameters: (news),
            escapingParameters: (news),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.changeFavoriteState(news: news))
        
    }
    

	 struct __StubbingProxy_FavoriteDelegate: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func changeFavoriteState<M1: Cuckoo.Matchable>(news: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Article)> where M1.MatchedType == Article {
	        let matchers: [Cuckoo.ParameterMatcher<(Article)>] = [wrap(matchable: news) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFavoriteDelegate.self, method: "changeFavoriteState(news: Article)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FavoriteDelegate: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func changeFavoriteState<M1: Cuckoo.Matchable>(news: M1) -> Cuckoo.__DoNotUse<(Article), Void> where M1.MatchedType == Article {
	        let matchers: [Cuckoo.ParameterMatcher<(Article)>] = [wrap(matchable: news) { $0 }]
	        return cuckoo_manager.verify("changeFavoriteState(news: Article)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class FavoriteDelegateStub: FavoriteDelegate {
    

    

    
     func changeFavoriteState(news: Article)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: News App/Manager/ArticleRepository.swift at 2019-08-09 08:47:46 +0000

//
//  DataRepository.swift
//  News App
//
//  Created by Matej Hetzel on 07/08/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Cuckoo
@testable import News_App

import Foundation
import RxCocoa
import RxSwift


 class MockArticleRepository: ArticleRepository, Cuckoo.ClassMock {
    
     typealias MocksType = ArticleRepository
    
     typealias Stubbing = __StubbingProxy_ArticleRepository
     typealias Verification = __VerificationProxy_ArticleRepository

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: ArticleRepository?

     func enableDefaultImplementation(_ stub: ArticleRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func alamofireRequest() -> Observable<[Article]> {
        
    return cuckoo_manager.call("alamofireRequest() -> Observable<[Article]>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.alamofireRequest()
                ,
            defaultCall: __defaultImplStub!.alamofireRequest())
        
    }
    

	 struct __StubbingProxy_ArticleRepository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func alamofireRequest() -> Cuckoo.ClassStubFunction<(), Observable<[Article]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockArticleRepository.self, method: "alamofireRequest() -> Observable<[Article]>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ArticleRepository: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func alamofireRequest() -> Cuckoo.__DoNotUse<(), Observable<[Article]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("alamofireRequest() -> Observable<[Article]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ArticleRepositoryStub: ArticleRepository {
    

    

    
     override func alamofireRequest() -> Observable<[Article]>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<[Article]>).self)
    }
    
}


// MARK: - Mocks generated from file: News App/Manager/RealmManager.swift at 2019-08-09 08:47:46 +0000

//
//  RealmManager.swift
//  News App
//
//  Created by Matej Hetzel on 17/07/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Cuckoo
@testable import News_App

import RealmSwift
import RxSwift
import UIKit


 class MockRealmManager: RealmManager, Cuckoo.ClassMock {
    
     typealias MocksType = RealmManager
    
     typealias Stubbing = __StubbingProxy_RealmManager
     typealias Verification = __VerificationProxy_RealmManager

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: RealmManager?

     func enableDefaultImplementation(_ stub: RealmManager) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func addobjToRealm(usedNew: Article, index: IndexPath)  {
        
    return cuckoo_manager.call("addobjToRealm(usedNew: Article, index: IndexPath)",
            parameters: (usedNew, index),
            escapingParameters: (usedNew, index),
            superclassCall:
                
                super.addobjToRealm(usedNew: usedNew, index: index)
                ,
            defaultCall: __defaultImplStub!.addobjToRealm(usedNew: usedNew, index: index))
        
    }
    
    
    
     override func deleteObject(usedNew: Article, index: IndexPath)  {
        
    return cuckoo_manager.call("deleteObject(usedNew: Article, index: IndexPath)",
            parameters: (usedNew, index),
            escapingParameters: (usedNew, index),
            superclassCall:
                
                super.deleteObject(usedNew: usedNew, index: index)
                ,
            defaultCall: __defaultImplStub!.deleteObject(usedNew: usedNew, index: index))
        
    }
    
    
    
     override func loadRealmData() -> Observable<Results<NewsFavorite>> {
        
    return cuckoo_manager.call("loadRealmData() -> Observable<Results<NewsFavorite>>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.loadRealmData()
                ,
            defaultCall: __defaultImplStub!.loadRealmData())
        
    }
    

	 struct __StubbingProxy_RealmManager: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func addobjToRealm<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(usedNew: M1, index: M2) -> Cuckoo.ClassStubNoReturnFunction<(Article, IndexPath)> where M1.MatchedType == Article, M2.MatchedType == IndexPath {
	        let matchers: [Cuckoo.ParameterMatcher<(Article, IndexPath)>] = [wrap(matchable: usedNew) { $0.0 }, wrap(matchable: index) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRealmManager.self, method: "addobjToRealm(usedNew: Article, index: IndexPath)", parameterMatchers: matchers))
	    }
	    
	    func deleteObject<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(usedNew: M1, index: M2) -> Cuckoo.ClassStubNoReturnFunction<(Article, IndexPath)> where M1.MatchedType == Article, M2.MatchedType == IndexPath {
	        let matchers: [Cuckoo.ParameterMatcher<(Article, IndexPath)>] = [wrap(matchable: usedNew) { $0.0 }, wrap(matchable: index) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRealmManager.self, method: "deleteObject(usedNew: Article, index: IndexPath)", parameterMatchers: matchers))
	    }
	    
	    func loadRealmData() -> Cuckoo.ClassStubFunction<(), Observable<Results<NewsFavorite>>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockRealmManager.self, method: "loadRealmData() -> Observable<Results<NewsFavorite>>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_RealmManager: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func addobjToRealm<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(usedNew: M1, index: M2) -> Cuckoo.__DoNotUse<(Article, IndexPath), Void> where M1.MatchedType == Article, M2.MatchedType == IndexPath {
	        let matchers: [Cuckoo.ParameterMatcher<(Article, IndexPath)>] = [wrap(matchable: usedNew) { $0.0 }, wrap(matchable: index) { $0.1 }]
	        return cuckoo_manager.verify("addobjToRealm(usedNew: Article, index: IndexPath)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func deleteObject<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(usedNew: M1, index: M2) -> Cuckoo.__DoNotUse<(Article, IndexPath), Void> where M1.MatchedType == Article, M2.MatchedType == IndexPath {
	        let matchers: [Cuckoo.ParameterMatcher<(Article, IndexPath)>] = [wrap(matchable: usedNew) { $0.0 }, wrap(matchable: index) { $0.1 }]
	        return cuckoo_manager.verify("deleteObject(usedNew: Article, index: IndexPath)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func loadRealmData() -> Cuckoo.__DoNotUse<(), Observable<Results<NewsFavorite>>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("loadRealmData() -> Observable<Results<NewsFavorite>>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class RealmManagerStub: RealmManager {
    

    

    
     override func addobjToRealm(usedNew: Article, index: IndexPath)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func deleteObject(usedNew: Article, index: IndexPath)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func loadRealmData() -> Observable<Results<NewsFavorite>>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Results<NewsFavorite>>).self)
    }
    
}

