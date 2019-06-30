//
//  AppDelegate.swift
//  Pure Dividends
//
//  Created by Alex Bush on 5/31/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import UIKit
import RIBs

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?
    
    private var launchRouter: LaunchRouting?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let launchRouter = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = launchRouter
        launchRouter.launchFromWindow(window)
        
        return true
    }

}

