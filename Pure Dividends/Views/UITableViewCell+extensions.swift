//
//  UITableViewCell+extensions.swift
//  Pure Dividends
//
//  Created by Alex Bush on 6/29/19.
//  Copyright © 2019 The iOS Interview Guide. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return NSStringFromClass(self)
    }
}
