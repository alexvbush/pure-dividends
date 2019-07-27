//
//  PortfolioViewController.swift
//  Pure Dividends
//
//  Created by Alex Bush on 7/21/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol PortfolioPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class PortfolioViewController: UINavigationController, PortfolioPresentable, PortfolioViewControllable {

    weak var listener: PortfolioPresentableListener?
    
}
