//
//  IEXClient.swift
//  PDNetworking
//
//  Created by Alex Bush on 6/30/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import RxSwift

public protocol IEXClientInterface {
    func getPrice(ticker: String) -> Observable<Double>
}

public final class IEXClient: IEXClientInterface {
    public func getPrice(ticker: String) -> Observable<Double> {
        return Observable.just(0.0)
    }
}
