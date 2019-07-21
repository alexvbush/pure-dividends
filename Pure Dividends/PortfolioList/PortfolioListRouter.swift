//
//  PortfolioRouter.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol PortfolioListInteractable: Interactable {
    var router: PortfolioListRouting? { get set }
    var listener: PortfolioListListener? { get set }
}

protocol PortfolioListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class PortfolioListRouter: ViewableRouter<PortfolioListInteractable, PortfolioListViewControllable>, PortfolioListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: PortfolioListInteractable, viewController: PortfolioListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
