//
//  StockDetailsRouter.swift
//  Pure Dividends
//
//  Created by Alex Bush on 7/27/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol StockDetailsInteractable: Interactable {
    var router: StockDetailsRouting? { get set }
    var listener: StockDetailsListener? { get set }
}

protocol StockDetailsViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class StockDetailsRouter: ViewableRouter<StockDetailsInteractable, StockDetailsViewControllable>, StockDetailsRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: StockDetailsInteractable, viewController: StockDetailsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
