//
//  ViewControllable+Navigation.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs

extension ViewControllable where Self: UIViewController {
    
    func navigateTo(viewControllable: ViewControllable) {
        let rootViewController = self.uiviewController
        
        if let oldViewController = rootViewController.children.first {
            oldViewController.willMove(toParent: nil)
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
        }
        
        let viewController = viewControllable.uiviewController
        
        rootViewController.addChild(viewController)
        rootViewController.view.addSubview(viewController.view)
        viewController.view.frame = rootViewController.view.bounds
        viewController.didMove(toParent: rootViewController)
    }
    
    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }
}
