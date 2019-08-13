//
//  AddStockRouter.swift
//  Pure Dividends
//
//  Created by Alex Bush on 8/12/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol AddStockInteractable: Interactable {
    var router: AddStockRouting? { get set }
    var listener: AddStockListener? { get set }
}

protocol AddStockViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class AddStockRouter: ViewableRouter<AddStockInteractable, AddStockViewControllable>, AddStockRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: AddStockInteractable, viewController: AddStockViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
