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
import RxCocoa

protocol AddStockPresentableListener: class {
    func done()
    func addStock()
    func didEnterTicker(_ ticker: String)
}

final class AddStockViewController: UIViewController, AddStockPresentable, AddStockViewControllable, UITextFieldDelegate {
    
    private let disposeBag = DisposeBag()

    weak var listener: AddStockPresentableListener?
    
    private var enteredTickerString = ""
    
    private let errorLabel = UILabel()
    private let stockTickerTextField = UITextField()
    private lazy var addButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addButtonTap(_:)))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupCloseButton()
        setupDoneButton()
        setupStockTickerTextField()
        setupErrorLabel()
    }

    private func setupCloseButton() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeButtonTap(_:)))
        navigationItem.leftBarButtonItem = closeButton
    }
    
    private func setupDoneButton() {
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupStockTickerTextField() {
        stockTickerTextField.borderStyle = .line
        stockTickerTextField.placeholder = "ticker. Ex: T"
        view.addSubview(stockTickerTextField)
        
        stockTickerTextField.snp.makeConstraints { (maker) in
            maker.centerX.centerY.equalToSuperview()
        }
        
        stockTickerTextField.rx.text.subscribe(onNext: { [weak self] (newText) in
            if let ticker = newText {
                self?.enteredTickerString = ticker
            }
        }).disposed(by: disposeBag)
        
        stockTickerTextField.delegate = self
    }
    
    @objc private func closeButtonTap(_ addButton: UIBarButtonItem) {
        listener?.done()
    }
    
    @objc private func addButtonTap(_ addButton: UIBarButtonItem) {
        listener?.addStock()
    }
    
    private func setupErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(stockTickerTextField)
            maker.bottom.equalTo(stockTickerTextField.snp.top)
        }
    }
    
    func showFoundTickerMessage(_ matchedTickerSearchResultItem: TickerSearchResultItem) {
        errorLabel.textColor = .green
        errorLabel.text = "Found \(matchedTickerSearchResultItem.symbol) 👍"
    }
    
    func showCantFindTickerMessage(_ passedTicker: String) {
        errorLabel.textColor = .red
        errorLabel.text = "Can't find \(passedTicker)"
    }
}

// MARK: UITextFieldDelegate
extension AddStockViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if !enteredTickerString.isEmpty {
            listener?.didEnterTicker(enteredTickerString)
        }
        
        return true
    }
}
