//
//  AddStockViewController.swift
//  Pure Dividends
//
//  Created by Alex Bush on 8/12/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol AddStockPresentableListener: class {
    func done()
}

final class AddStockViewController: UIViewController, AddStockPresentable, AddStockViewControllable {

    weak var listener: AddStockPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeButtonTap(_:)))
        navigationItem.leftBarButtonItem = closeButton
        
        let stockTickerTextField = UITextField()
        stockTickerTextField.borderStyle = .line
        stockTickerTextField.placeholder = "ticker. Ex: T"
        view.addSubview(stockTickerTextField)
        
        stockTickerTextField.snp.makeConstraints { (maker) in
            maker.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc private func closeButtonTap(_ addButton: UIBarButtonItem) {
        listener?.done()
    }
}
