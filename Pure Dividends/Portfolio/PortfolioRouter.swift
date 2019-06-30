//
//  PortfolioRouter.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol PortfolioInteractable: Interactable {
    var router: PortfolioRouting? { get set }
    var listener: PortfolioListener? { get set }
}

protocol PortfolioViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class PortfolioRouter: ViewableRouter<PortfolioInteractable, PortfolioViewControllable>, PortfolioRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: PortfolioInteractable, viewController: PortfolioViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
