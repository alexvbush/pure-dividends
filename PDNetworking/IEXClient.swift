//
//  IEXClient.swift
//  PDNetworking
//
//  Created by Alex Bush on 6/30/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RxSwift
import RxAlamofire
import Alamofire

public protocol IEXClientInterface {
    func getPrice(ticker: String) -> Observable<Double>
}

public final class IEXClient: IEXClientInterface {
    
    private let manager: SessionManager
    
    private let token = "Tsk_5b6a7d4e02db464b9447f498407d78f4"
    
    public init(manager: SessionManager) {
        self.manager = manager
    }
    
    public func getPrice(ticker: String) -> Observable<Double> {
        let url = URL(string: "https://sandbox.iexapis.com/v1/stock/\(ticker)/price?token=\(token)")!
        return manager.rx.json(.get, url).map { (response) -> Double in
            return response as! Double
        }
    }
}
