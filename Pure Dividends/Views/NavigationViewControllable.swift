//
//  NavigationViewControllable.swift
//  Pure Dividends
//
//  Created by Alex Bush on 7/27/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

protocol NavigationViewControllable: ViewControllable {
    func pushViewControllable(_ newViewControllable: ViewControllable, animated: Bool)
    func popLastViewControllable(animated: Bool)
    func present(viewController: ViewControllable)
}

extension NavigationViewControllable where Self: UINavigationController {
    func pushViewControllable(_ newViewControllable: ViewControllable, animated: Bool) {
        pushViewController(newViewControllable.uiviewController, animated: animated)
    }
    
    // NOTE: that's a duplicate from BaseViewControllable, might be a good idea to consolidate
    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    func popLastViewControllable(animated: Bool) {
        popViewController(animated: animated)
    }
}
