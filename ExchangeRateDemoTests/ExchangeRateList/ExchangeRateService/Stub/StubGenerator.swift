//
//  StubGenerator.swift
//  ExchangeRateDemoTests
//
//  Created by Shun on 2018/8/2.
//  Copyright © 2018年 com.shun.demo. All rights reserved.
//

import Foundation

class StubGenerator {
    func stubExchangeRateData() -> Data {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "mock_content", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        return data
    }
}
