//
//  StockDetailsBuilder.swift
//  Pure Dividends
//
//  Created by Alex Bush on 7/27/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol StockDetailsDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class StockDetailsComponent: Component<StockDetailsDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol StockDetailsBuildable: Buildable {
    func build(withListener listener: StockDetailsListener) -> StockDetailsRouting
}

final class StockDetailsBuilder: Builder<StockDetailsDependency>, StockDetailsBuildable {

    override init(dependency: StockDetailsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: StockDetailsListener) -> StockDetailsRouting {
        let component = StockDetailsComponent(dependency: dependency)
        let viewController = StockDetailsViewController()
        let interactor = StockDetailsInteractor(presenter: viewController)
        interactor.listener = listener
        return StockDetailsRouter(interactor: interactor, viewController: viewController)
    }
}
