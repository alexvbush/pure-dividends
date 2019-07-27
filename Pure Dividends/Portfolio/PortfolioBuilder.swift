//
//  PortfolioBuilder.swift
//  Pure Dividends
//
//  Created by Alex Bush on 7/21/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol PortfolioDependency: Dependency {
    var iexService: IEXServiceInterface { get }
    var stocksStorage: StocksStorageInterface { get }
}

final class PortfolioComponent: Component<PortfolioDependency>, PortfolioListDependency {
    
    var iexService: IEXServiceInterface {
        return dependency.iexService
    }
    
    var stocksStorage: StocksStorageInterface {
        return dependency.stocksStorage
    }
}

// MARK: - Builder

protocol PortfolioBuildable: Buildable {
    func build(withListener listener: PortfolioListener) -> PortfolioRouting
}

final class PortfolioBuilder: Builder<PortfolioDependency>, PortfolioBuildable {

    override init(dependency: PortfolioDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: PortfolioListener) -> PortfolioRouting {
        let component = PortfolioComponent(dependency: dependency)
        let viewController = PortfolioViewController()
        let interactor = PortfolioInteractor(presenter: viewController)
        interactor.listener = listener
        
        let portfolioListBuilder = PortfolioListBuilder(dependency: component)
        
        return PortfolioRouter(interactor: interactor,
                               viewController: viewController,
                               portfolioListBuilder: portfolioListBuilder)
    }
}
