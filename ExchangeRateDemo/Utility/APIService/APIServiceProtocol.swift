//
//  APIServiceProtocol.swift
//  ExchangeRateDemo
//
//  Created by Shun on 2018/7/31.
//  Copyright © 2018年 com.shun.demo. All rights reserved.
//

import Foundation

@objc protocol APIServiceProtocol {
    
    var urlString: String {get set}
    
    @objc optional func fetchDownloadDatas( complete: @escaping ( _ data: Data?, _ destinationURL: URL?, _ error: String? )->() )
}
