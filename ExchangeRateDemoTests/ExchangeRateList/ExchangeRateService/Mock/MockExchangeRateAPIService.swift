//
//  MockExchangeRateAPIService.swift
//  ExchangeRateDemoTests
//
//  Created by Shun on 2018/8/1.
//  Copyright © 2018年 com.shun.demo. All rights reserved.
//

import Foundation
@testable import ExchangeRateDemo

class MockExchangeRateAPIService: APIServiceProtocol {
   
    var urlString: String
    
    private var isDataNeedError: Bool = false

    func fetchDownloadDatas( complete: @escaping ( _ data: Data?, _ destinationURL: URL?, _ error: String? )->() ){
        
        if (self.isDataNeedError){
            return complete(Data(), nil, nil)
        }
        
        let data = StubGenerator().stubExchangeRateData()
        //let datastring = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        
        complete(data, nil, nil)
    }
    
    init(urlString: String = "www.mock.api") {
        self.urlString = urlString
    }
    
    func setIsDataNeedError(isDataNeedError: Bool){
        self.isDataNeedError = isDataNeedError
    }

}
