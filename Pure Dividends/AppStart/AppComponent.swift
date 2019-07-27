//
//  AppComponent.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/21/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import Foundation
import RIBs
import PDPersistence
import PDNetworking
import Alamofire

class AppComponent: Component<EmptyDependency>, RootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
    
    var sessionManager: SessionManagerInterface {
        let sessionManager = SessionManager()
        sessionManager.save(session: Session(token: "jslfdhk"))
        return sessionManager
    }
        
    var iexService: IEXServiceInterface {
        return IEXService(client: iexClient)
    }
    
    var stocksStorage: StocksStorageInterface {
        return StocksStorage(keyValueStore: keyValueStore)
    }
    
    fileprivate var networkSessionManager: Alamofire.SessionManager {
        return Alamofire.SessionManager.default
    }
    
    fileprivate var iexClient: IEXClientInterface {
        return IEXClient(manager: networkSessionManager)
    }
    
    fileprivate var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    fileprivate var keyValueStore: KeyValueStoreInterface {
        return KeyValueStore(userDefaults)
    }
}
