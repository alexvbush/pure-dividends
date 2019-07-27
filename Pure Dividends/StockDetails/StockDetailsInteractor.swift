//
//  StockDetailsInteractor.swift
//  Pure Dividends
//
//  Created by Alex Bush on 7/27/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs
import RxSwift

protocol StockDetailsRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol StockDetailsPresentable: Presentable {
    var listener: StockDetailsPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol StockDetailsListener: class {
    func didComplete(_ interactor: StockDetailsInteractable)
}

final class StockDetailsInteractor: PresentableInteractor<StockDetailsPresentable>, StockDetailsInteractable, StockDetailsPresentableListener {

    weak var router: StockDetailsRouting?
    weak var listener: StockDetailsListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: StockDetailsPresentable) {
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
    
    func goBack() {
        listener?.didComplete(self)
    }
}
