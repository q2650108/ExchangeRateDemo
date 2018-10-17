//
//  ExchangeRateServiceProtocol.swift
//  ExchangeRateDemo
//
//  Created by Shun on 2018/8/1.
//  Copyright © 2018年 com.shun.demo. All rights reserved.
//

import Foundation

protocol ExchangeRateServiceProtocol {
    func fetchExchangeRateListSectionVMs(complete: @escaping (_ vms: [ExchangeRateListSectionVM], _ errorMessage: String? ) -> Void)
}

