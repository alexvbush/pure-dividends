//
//  RootBuilder.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/21/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
    var sessionManager: SessionManagerInterface { get }
    var iexService: IEXServiceInterface { get }
    var stocksStorage: StocksStorageInterface { get }
}

final class RootComponent: Component<RootDependency>, PortfolioDependency {
    
    fileprivate var sessionManager: SessionManagerInterface {
        return dependency.sessionManager
    }
    
    var iexService: IEXServiceInterface {
        return dependency.iexService
    }
    
    var stocksStorage: StocksStorageInterface {
        return dependency.stocksStorage
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController,
                                        sessionManager: component.sessionManager)
                
        let portfolioBuilder = PortfolioBuilder(dependency: component)
        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          portfolioBuilder: portfolioBuilder)
    }
}
