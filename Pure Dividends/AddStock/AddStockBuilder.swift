//
//  AddStockBuilder.swift
//  Pure Dividends
//
//  Created by Alex Bush on 8/12/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol AddStockDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AddStockComponent: Component<AddStockDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AddStockBuildable: Buildable {
    func build(withListener listener: AddStockListener) -> AddStockRouting
}

final class AddStockBuilder: Builder<AddStockDependency>, AddStockBuildable {

    override init(dependency: AddStockDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AddStockListener) -> AddStockRouting {
        let component = AddStockComponent(dependency: dependency)
        let viewController = AddStockViewController()
        let interactor = AddStockInteractor(presenter: viewController)
        interactor.listener = listener
        return AddStockRouter(interactor: interactor, viewController: viewController)
    }
}
