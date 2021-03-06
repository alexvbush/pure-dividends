//
//  RootRouter.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/21/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, PortfolioListListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: BaseViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let portfolioListBuilder: PortfolioListBuildable
    private var portfolioListRouter: PortfolioListRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable,
                  viewController: RootViewControllable,
                  portfolioListBuilder: PortfolioListBuildable) {
        self.portfolioListBuilder = portfolioListBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // called when router has finished loading
    override func didLoad() {
        super.didLoad()
        
        // one time setup logic here
    }
    
    func routeToMainScreen() {        
        let portfolioListRouter = portfolioListBuilder.build(withListener: interactor)
        self.portfolioListRouter = portfolioListRouter
        attachChild(portfolioListRouter)
        viewController.navigateTo(viewControllable: portfolioListRouter.viewControllable)
    }
    
//    func routeAwayFromMainScreen() {
//        if let childRouter = portfolioListRouter, let childNavController = mainScreenNavController {
//            childNavController.uiviewController.willMove(toParent: viewController.uiviewController)
//            childNavController.uiviewController.view.removeFromSuperview()
//            childNavController.uiviewController.removeFromParent()
//            detachChild(childRouter)
//            self.portfolioListRouter = nil
//        }
//    }
}
