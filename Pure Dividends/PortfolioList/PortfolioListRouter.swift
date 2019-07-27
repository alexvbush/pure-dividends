//
//  PortfolioRouter.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol PortfolioListInteractable: Interactable, StockDetailsListener {
    var router: PortfolioListRouting? { get set }
    var listener: PortfolioListListener? { get set }
}

protocol PortfolioListViewControllable: BaseViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class PortfolioListRouter: ViewableRouter<PortfolioListInteractable, PortfolioListViewControllable>, PortfolioListRouting {
    
    private let stockDetailsBuilder: StockDetailsBuildable
    private var stockDetailsRouter: StockDetailsRouting?
    
    init(interactor: PortfolioListInteractable,
         viewController: PortfolioListViewControllable,
         stockDetailsBuilder: StockDetailsBuildable) {
        self.stockDetailsBuilder = stockDetailsBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToStockDetals(_ stock: StockModel) {
        let stockDetailsRouter = stockDetailsBuilder.build(withListener: interactor,
                                                           stock: stock)
        self.stockDetailsRouter = stockDetailsRouter
        attachChild(stockDetailsRouter)
        viewController.push(viewControllable: stockDetailsRouter.viewControllable, animated: true)
    }
    
    func routeAwayFromStockDetals() {
        if let stockDetailsRouter = stockDetailsRouter {
            self.stockDetailsRouter = nil
            detachChild(stockDetailsRouter)
            viewController.popLastViewControllable(animated: true)
        }
    }
}
