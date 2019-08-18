//
//  AddStockInteractor.swift
//  Pure Dividends
//
//  Created by Alex Bush on 8/12/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RIBs
import RxSwift

protocol AddStockRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AddStockPresentable: Presentable {
    var listener: AddStockPresentableListener? { get set }
    
    func showFoundTickerMessage(_ matchedTickerSearchResultItem: TickerSearchResultItem)
    func showCantFindTickerMessage(_ passedTicker: String)
}

protocol AddStockListener: class {
    func didComplete(_ interactor: AddStockInteractable)
    func didComplete(_ interactor: AddStockInteractable, withSelectedTickerToAdd selectedTicker: TickerSearchResultItem)
}

final class AddStockInteractor: PresentableInteractor<AddStockPresentable>, AddStockInteractable, AddStockPresentableListener {

    weak var router: AddStockRouting?
    weak var listener: AddStockListener?
    
    private let iexService: IEXServiceInterface
    
    private var enteredTicker: TickerSearchResultItem?
    
    init(presenter: AddStockPresentable,
         iexService: IEXServiceInterface) {
        self.iexService = iexService
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func done() {
        listener?.didComplete(self)
    }
    
    func addStock() {
        if let selectedTicker = enteredTicker {
            listener?.didComplete(self, withSelectedTickerToAdd: selectedTicker)
        }
    }
    
    func didEnterTicker(_ ticker: String) {
        iexService.search(ticker: ticker).subscribe(onNext: { [weak self] (tickerSearchResultItems) in
            
            if let matchedTickerSearchResultItem = tickerSearchResultItems.first(where: { (tickerSearchResultItem) -> Bool in
                return tickerSearchResultItem.symbol == ticker
            }) {
                self?.enteredTicker = matchedTickerSearchResultItem
                self?.presenter.showFoundTickerMessage(matchedTickerSearchResultItem)
            } else {
                self?.enteredTicker = nil
                self?.presenter.showCantFindTickerMessage(ticker)
            }
            
        }, onError: { (error) in
            print("error: \(error)")
        }).disposeOnDeactivate(interactor: self)
    }
}
