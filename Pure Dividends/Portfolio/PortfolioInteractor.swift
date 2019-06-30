//
//  PortfolioInteractor.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs
import RxSwift

protocol PortfolioRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol PortfolioPresentable: Presentable {
    var listener: PortfolioPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol PortfolioListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class PortfolioInteractor: PresentableInteractor<PortfolioPresentable>, PortfolioInteractable, PortfolioPresentableListener {

    weak var router: PortfolioRouting?
    weak var listener: PortfolioListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: PortfolioPresentable) {
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
}