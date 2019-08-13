//
//  AddStockInteractor.swift
//  Pure Dividends
//
//  Created by Alex Bush on 8/12/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs
import RxSwift

protocol AddStockRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AddStockPresentable: Presentable {
    var listener: AddStockPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol AddStockListener: class {
    func didComplete(_ interactor: AddStockInteractable)
}

final class AddStockInteractor: PresentableInteractor<AddStockPresentable>, AddStockInteractable, AddStockPresentableListener {

    weak var router: AddStockRouting?
    weak var listener: AddStockListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: AddStockPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func done() {
        listener?.didComplete(self)
    }
}
