//
//  RootRouter.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/21/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, PortfolioListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: BaseViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let portfolioBuilder: PortfolioBuildable
    private var portfolioRouter: PortfolioRouting?

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable,
                  viewController: RootViewControllable,
                  portfolioBuilder: PortfolioBuildable) {        
        self.portfolioBuilder = portfolioBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // called when router has finished loading
    override func didLoad() {
        super.didLoad()
        
        // one time setup logic here
    }
    
    func routeToMainScreen() {        
        let portfolioRouter = portfolioBuilder.build(withListener: interactor)
        self.portfolioRouter = portfolioRouter
        attachChild(portfolioRouter)
        viewController.navigateTo(viewControllable: portfolioRouter.viewControllable)
    }
}
