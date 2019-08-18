//
//  AddStockBuilder.swift
//  Pure Dividends
//
//  Created by Alex Bush on 8/12/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol AddStockDependency: Dependency {
    var iexService: IEXServiceInterface { get }
}

final class AddStockComponent: Component<AddStockDependency> {
    fileprivate var iexService: IEXServiceInterface {
        return dependency.iexService
    }
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
        let interactor = AddStockInteractor(presenter: viewController,
                                            iexService: component.iexService)
        interactor.listener = listener
        return AddStockRouter(interactor: interactor, viewController: viewController)
    }
}
