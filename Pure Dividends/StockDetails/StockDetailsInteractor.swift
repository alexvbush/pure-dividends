//
//  StockDetailsInteractor.swift
//  Pure Dividends
//
//  Created by Alex Bush on 7/27/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs
import RxSwift

protocol StockDetailsRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol StockDetailsPresentable: Presentable {
    var listener: StockDetailsPresentableListener? { get set }
    
    func present(stock: StockModel)
    func present(stock: StockModel, withStockQuote stockQuote: StockQuoteModel)
}

protocol StockDetailsListener: class {
    func didComplete(_ interactor: StockDetailsInteractable)
}

final class StockDetailsInteractor: PresentableInteractor<StockDetailsPresentable>, StockDetailsInteractable, StockDetailsPresentableListener {

    weak var router: StockDetailsRouting?
    weak var listener: StockDetailsListener?
    
    private let iexService: IEXServiceInterface
    
    private let stock: StockModel
    private var stockQuote: StockQuoteModel?
    
    init(presenter: StockDetailsPresentable,
         iexService: IEXServiceInterface,
         stock: StockModel) {
        self.iexService = iexService
        self.stock = stock
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        presenter.present(stock: stock)
        
        iexService.fetchStockQuote(stock).subscribe(onNext: { (stockQuote) in
            self.stockQuote = stockQuote
            self.presenter.present(stock: self.stock, withStockQuote: stockQuote)
        }, onError: { (error) in
            print("error: \(error)")
        }).disposeOnDeactivate(interactor: self)
    }
    
    override func willResignActive() {
        
        // cleanup
        super.willResignActive()
    }
    
    func goBack() {
        listener?.didComplete(self)
    }
}
