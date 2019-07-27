//
//  StockDetailsViewController.swift
//  Pure Dividends
//
//  Created by Alex Bush on 7/27/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol StockDetailsPresentableListener: class {
    func goBack()
}

final class StockDetailsViewController: UIViewController, StockDetailsPresentable, StockDetailsViewControllable {

    weak var listener: StockDetailsPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green

        let backButton = UIBarButtonItem()
        backButton.target = self
        backButton.action = #selector(backButtonTap(_:))
        backButton.title = "< Go Back"
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTap(_ backButton: UIBarButtonItem) {
        listener?.goBack()
    }
}
