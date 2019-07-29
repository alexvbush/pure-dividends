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
import SnapKit

protocol StockDetailsPresentableListener: class {
    func goBack()
}

final class StockDetailsViewController: UIViewController, StockDetailsPresentable, StockDetailsViewControllable {

    weak var listener: StockDetailsPresentableListener?
    
    private let tickerTextLabel = UILabel()
    private let openTextLabel = UILabel()
    private let closeTextLabel = UILabel()
    private let highTextLabel = UILabel()
    private let lowTextLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupBackButton()
        
        setupStockLabels()
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem()
        backButton.target = self
        backButton.action = #selector(backButtonTap(_:))
        backButton.title = "< Go Back"
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupStockLabels() {
        let tickerLabel = UILabel()
        tickerLabel.text = "Ticker:"
        view.addSubview(tickerLabel)
        tickerLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            maker.leading.equalToSuperview().offset(50)
        }
        
        tickerTextLabel.text = "..."
        view.addSubview(tickerTextLabel)
        tickerTextLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(tickerLabel)
            maker.leading.equalTo(tickerLabel.snp.trailing).offset(10)
        }
        
        
        let openLabel = UILabel()
        openLabel.text = "Open:"
        view.addSubview(openLabel)
        openLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(tickerLabel.snp.bottom).offset(10)
            maker.trailing.equalTo(tickerLabel.snp.trailing)
        }
        
        openTextLabel.text = "..."
        view.addSubview(openTextLabel)
        openTextLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(openLabel)
            maker.leading.equalTo(openLabel.snp.trailing).offset(10)
        }
        
        
        let closeLabel = UILabel()
        closeLabel.text = "Close:"
        view.addSubview(closeLabel)
        closeLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(openLabel.snp.bottom).offset(10)
            maker.trailing.equalTo(openLabel.snp.trailing)
        }
        
        closeTextLabel.text = "..."
        view.addSubview(closeTextLabel)
        closeTextLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(closeLabel)
            maker.leading.equalTo(closeLabel.snp.trailing).offset(10)
        }
        
        
        // high
        let highLabel = UILabel()
        highLabel.text = "High:"
        view.addSubview(highLabel)
        highLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(openLabel)
            maker.leading.equalTo(view.snp.centerX)
        }
        
        highTextLabel.text = "..."
        view.addSubview(highTextLabel)
        highTextLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(highLabel)
            maker.leading.equalTo(highLabel.snp.trailing).offset(10)
        }
        //
        
        
        // low
        let lowLabel = UILabel()
        lowLabel.text = "Low:"
        view.addSubview(lowLabel)
        lowLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(highLabel.snp.bottom).offset(10)
            maker.trailing.equalTo(highLabel.snp.trailing)
        }
        
        lowTextLabel.text = "..."
        view.addSubview(lowTextLabel)
        lowTextLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(lowLabel)
            maker.leading.equalTo(lowLabel.snp.trailing).offset(10)
        }
        //
    }
    
    @objc private func backButtonTap(_ backButton: UIBarButtonItem) {
        listener?.goBack()
    }
    
    func present(stock: StockModel) {
        tickerTextLabel.text = stock.ticker
    }
    
    func present(stock: StockModel, withStockQuote stockQuote: StockQuoteModel) {
        tickerTextLabel.text = stock.ticker
        
        openTextLabel.text = "$\(stockQuote.open)"
        closeTextLabel.text = "$\(stockQuote.close)"
        highTextLabel.text = "$\(stockQuote.high)"
        lowTextLabel.text = "$\(stockQuote.low)"        
    }
}
