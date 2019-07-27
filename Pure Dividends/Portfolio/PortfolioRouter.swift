//
//  PortfolioRouter.swift
//  Pure Dividends
//
//  Created by Alex Bush on 7/21/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol PortfolioInteractable: Interactable, PortfolioListListener {
    var router: PortfolioRouting? { get set }
    var listener: PortfolioListener? { get set }
}

protocol PortfolioViewControllable: NavigationViewControllable {
    
}

final class PortfolioRouter: ViewableRouter<PortfolioInteractable, PortfolioViewControllable>, PortfolioRouting {
    
    private let portfolioListBuilder: PortfolioListBuildable
    private var portfolioListRouter: PortfolioListRouting?
    
    init(interactor: PortfolioInteractable,
         viewController: PortfolioViewControllable,
         portfolioListBuilder: PortfolioListBuildable) {
        self.portfolioListBuilder = portfolioListBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToPortfolioList() {
        let portfolioListRouter = portfolioListBuilder.build(withListener: interactor)
        self.portfolioListRouter = portfolioListRouter
        attachChild(portfolioListRouter)
        viewController.pushViewControllable(portfolioListRouter.viewControllable, animated: false)
    }
}
