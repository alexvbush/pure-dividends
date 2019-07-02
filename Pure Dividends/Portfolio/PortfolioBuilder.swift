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

protocol PortfolioDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class PortfolioComponent: Component<PortfolioDependency> {

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
        let interactor = PortfolioInteractor(presenter: viewController, iexService: component.iexService)
        interactor.listener = listener
        return PortfolioRouter(interactor: interactor, viewController: viewController)
    }
}
