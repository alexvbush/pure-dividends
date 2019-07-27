//
//  StockDetailsBuilder.swift
//  Pure Dividends
//
//  Created by Alex Bush on 7/27/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol StockDetailsDependency: Dependency {
    var iexService: IEXServiceInterface { get }
}

final class StockDetailsComponent: Component<StockDetailsDependency> {

    fileprivate var iexService: IEXServiceInterface {
        return dependency.iexService
    }
}

// MARK: - Builder

protocol StockDetailsBuildable: Buildable {
    func build(withListener listener: StockDetailsListener, stock: StockModel) -> StockDetailsRouting
}

final class StockDetailsBuilder: Builder<StockDetailsDependency>, StockDetailsBuildable {

    override init(dependency: StockDetailsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: StockDetailsListener, stock: StockModel) -> StockDetailsRouting {
        let component = StockDetailsComponent(dependency: dependency)
        let viewController = StockDetailsViewController()
        let interactor = StockDetailsInteractor(presenter: viewController,
                                                iexService: component.iexService,
                                                stock: stock)
        interactor.listener = listener
        return StockDetailsRouter(interactor: interactor, viewController: viewController)
    }
}
