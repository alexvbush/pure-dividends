//
//  PortfolioRouter.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol PortfolioListInteractable: Interactable, StockDetailsListener, AddStockListener {
    var router: PortfolioListRouting? { get set }
    var listener: PortfolioListListener? { get set }
}

protocol PortfolioListViewControllable: NavigationViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class PortfolioListRouter: ViewableRouter<PortfolioListInteractable, PortfolioListViewControllable>, PortfolioListRouting {
    
    private let stockDetailsBuilder: StockDetailsBuildable
    private var stockDetailsRouter: StockDetailsRouting?
    
    private let addStockBuilder: AddStockBuildable
    private var addStockRouter: AddStockRouting?
    
    init(interactor: PortfolioListInteractable,
         viewController: PortfolioListViewControllable,
         stockDetailsBuilder: StockDetailsBuildable,
         addStockBuilder: AddStockBuildable) {
        self.stockDetailsBuilder = stockDetailsBuilder
        self.addStockBuilder = addStockBuilder
        super.init(interactor: interactor, viewController: viewController)        
        interactor.router = self
    }
    
    func routeToStockDetals(_ stock: StockModel) {
        let stockDetailsRouter = stockDetailsBuilder.build(withListener: interactor,
                                                           stock: stock)
        self.stockDetailsRouter = stockDetailsRouter
        attachChild(stockDetailsRouter)
        viewController.pushViewControllable(stockDetailsRouter.viewControllable, animated: true)
    }
    
    func routeAwayFromStockDetals() {
        if let stockDetailsRouter = stockDetailsRouter {
            self.stockDetailsRouter = nil
            detachChild(stockDetailsRouter)
            viewController.popLastViewControllable(animated: true)
        }
    }
    
    func routeToAddStock() {
        let addStockRouter = addStockBuilder.build(withListener: interactor)
        self.addStockRouter = addStockRouter
        attachChild(addStockRouter)
        let navVC = UINavigationController(rootViewController: addStockRouter.viewControllable.uiviewController)
        viewController.uiviewController.present(navVC, animated: true, completion: nil)
    }
    
    func routeAwayFromAddStock() {
        if let addStockRouter = addStockRouter {
            self.addStockRouter = nil
            detachChild(addStockRouter)
            addStockRouter.viewControllable.uiviewController.dismiss(animated: true, completion: nil)
        }
    }
}
