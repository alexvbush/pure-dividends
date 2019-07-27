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
}

extension NavigationViewControllable where Self: UINavigationController {
    func pushViewControllable(_ newViewControllable: ViewControllable, animated: Bool) {
        pushViewController(newViewControllable.uiviewController, animated: animated)
    }
}
