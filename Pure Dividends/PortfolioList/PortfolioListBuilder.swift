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
    var iexService: IEXServiceInterface { get }
    var stocksStorage: StocksStorageInterface { get }
}

final class PortfolioListComponent: Component<PortfolioListDependency>, StockDetailsDependency, AddStockDependency {
    
    var iexService: IEXServiceInterface {
        return dependency.iexService
    }
    
    fileprivate var stocksStorage: StocksStorageInterface {
        return dependency.stocksStorage
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
        let listViewController = PortfolioListViewController()
        let navigationViewController = PortfolioNavigationViewController(rootViewController: listViewController)
        let interactor = PortfolioListInteractor(presenter: listViewController,
                                                 iexService: component.iexService,
                                                 stocksStorage: component.stocksStorage)
        interactor.listener = listener
        
        let stockDetailsBuilder = StockDetailsBuilder(dependency: component)
        let addStockBuilder = AddStockBuilder(dependency: component)
        
        return PortfolioListRouter(interactor: interactor,                                   
                                   viewController: navigationViewController,
                                   stockDetailsBuilder: stockDetailsBuilder,
                                   addStockBuilder: addStockBuilder)
    }
}
