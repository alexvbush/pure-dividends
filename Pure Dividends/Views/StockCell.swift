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
        nameLabel.numberOfLines = 0
        self.nameLabel = nameLabel
        
        let priceLabel = UILabel()
        self.priceLabel = priceLabel
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10

        stackView.addArrangedSubview(tickerLabel)
        stackView.addArrangedSubview(nameLabel)
        let bufferView = UIView()
        bufferView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(bufferView)
        stackView.addArrangedSubview(priceLabel)
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.top.equalToSuperview().offset(20)
            maker.bottom.equalToSuperview().offset(-20)
        }
        
        bufferView.snp.makeConstraints { (maker) in
            maker.height.equalTo(priceLabel.snp.height)
        }
    }
}
