//
//  ExchangeRateAPIService.swift
//  ExchangeRateDemo
//
//  Created by Shun on 2018/7/31.
//  Copyright © 2018年 com.shun.demo. All rights reserved.
//

import Foundation
import Alamofire

class ExchangeRateAPIService: APIServiceProtocol{
    // MARK: - Type Alias
    
    // MARK: - Property
    var urlString: String
    
    lazy var destination: DownloadRequest.DownloadFileDestination = {
        return DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
    }()
    
    // MARK: - Accessor
    
    // MARK: - Outlet
    
    // MARK: - Action
    
    // MARK: - Constructor
    init(urlString: String = "https://quality.data.gov.tw/dq_download_json.php?nid=11339&md5_url=f2fdbc21603c55b11aead08c84184b8f") {
        self.urlString = urlString
    }
    
    // MARK: - Life Cycle
    deinit {
        print("shun - \( type(of: self) ) deinit")
    }
    
    // MARK: - Private Func
    
    // MARK: - Public Func

    func fetchDownloadDatas(complete: @escaping ( _ data: Data?, _ destinationURL: URL?, _ error: String?) -> ()) {
        Alamofire.download(
            self.urlString,
            method: .get,
            encoding: JSONEncoding.default,
            to: self.destination)
            .downloadProgress(closure: {
                (progress) in
                //progress closure
            })
            .response(completionHandler: {
                (downloadResponse) in
                //print("request: \(downloadResponse.request)" )  // 原始的 URL 要求
                //print("response: \(downloadResponse.response)") // URL 回應

                var resultData: Data? = nil
                let destinationURL = downloadResponse.destinationURL
                var serviceError: String? = nil
                
                if let _error = downloadResponse.error {
                    serviceError = _error.localizedDescription
                }else{
                    if let fileUrl = destinationURL,
                        let data = NSData(contentsOfFile: fileUrl.path) as Data? {
                        resultData = data
                    }
                }
                
                complete(resultData,destinationURL,serviceError)
            })
    }
}
