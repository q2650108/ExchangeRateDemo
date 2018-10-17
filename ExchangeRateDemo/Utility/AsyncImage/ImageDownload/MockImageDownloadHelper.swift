//
//  MockImageDownloadHelper.swift
//  ExchangeRateDemo
//
//  Created by Shun on 2018/7/26.
//  Copyright © 2018年 com.shun.demo. All rights reserved.
//

import Foundation
import UIKit

class MockImageDownloadHelper: ImageDownloadHelperProtocol {
    func download(url: URL, completion: @escaping (UIImage?, URLResponse?, Error?) -> ()) {
        DispatchQueue.global().async {
            usleep(1000000 + (arc4random() % 9)*100000)
            completion(UIImage.init(named: url.path), nil, nil)
        }
    }
}
