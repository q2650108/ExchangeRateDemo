//
//  UITableViewCell+cellIdentifier.swift
//  ExchangeRateDemo
//
//  Created by Shun on 2018/7/24.
//  Copyright © 2018年 com.shun.demo. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    /// Generated cell identifier from class name
    public static func cellIdentifier() -> String {
        return String(describing: self)
    }
}
