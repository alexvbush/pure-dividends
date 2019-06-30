//
//  StockCell.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import UIKit
import SnapKit

final class StockCell: UITableViewCell {
    let tickerLabel: UILabel
    let nameLabel: UILabel
    let priceLabel: UILabel
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        let tickerLabel = UILabel()
        self.tickerLabel = tickerLabel
        
        let nameLabel = UILabel()
        self.nameLabel = nameLabel
        
        let priceLabel = UILabel()
        self.priceLabel = priceLabel
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(tickerLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        
        tickerLabel.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview().offset(20)
            maker.width.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
//            maker.top.bottom.equalToSuperview()
            maker.leading.equalTo(tickerLabel.snp.trailing).offset(20)
            maker.trailing.equalTo(priceLabel.snp.leading)
        }
        
        priceLabel.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.trailing.equalToSuperview().inset(20)
        }
        priceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}
