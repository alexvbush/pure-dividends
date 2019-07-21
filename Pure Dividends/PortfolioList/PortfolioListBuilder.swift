//
//  PortfolioBuilder.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs
import PDNetworking
import Alamofire
import PDPersistence

protocol PortfolioListDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class PortfolioListComponent: Component<PortfolioListDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
    fileprivate var sessionManager: Alamofire.SessionManager {
        return Alamofire.SessionManager.default
    }
    
    fileprivate var iexClient: IEXClientInterface {
        return IEXClient(manager: sessionManager)
    }
    
    fileprivate var iexService: IEXServiceInterface {
        return IEXService(client: iexClient)
    }
    
    fileprivate var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    fileprivate var keyValueStore: KeyValueStoreInterface {
        return KeyValueStore(userDefaults)
    }
    
    fileprivate var stocksStorage: StocksStorageInterface {
        return StocksStorage(keyValueStore: keyValueStore)
    }
}

// MARK: - Builder

protocol PortfolioListBuildable: Buildable {
    func build(withListener listener: PortfolioListListener) -> PortfolioListRouting
}

final class PortfolioListBuilder: Builder<PortfolioListDependency>, PortfolioListBuildable {

    override init(dependency: PortfolioListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: PortfolioListListener) -> PortfolioListRouting {
        let component = PortfolioListComponent(dependency: dependency)
        let viewController = PortfolioListViewController()
        let interactor = PortfolioListInteractor(presenter: viewController,
                                                 iexService: component.iexService,
                                                 stocksStorage: component.stocksStorage)
        interactor.listener = listener
        return PortfolioListRouter(interactor: interactor, viewController: viewController)
    }
}
