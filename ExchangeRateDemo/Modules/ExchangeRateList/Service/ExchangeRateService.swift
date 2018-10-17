//
//  ExchangeRateService.swift
//  ExchangeRateDemo
//
//  Created by Shun on 2018/7/25.
//  Copyright © 2018年 com.shun.demo. All rights reserved.
//

import Foundation

class ExchangeRateService: ExchangeRateServiceProtocol{
    
    // MARK: - Type Alias
    
    // MARK: - Property
    
    
    private let aPIService: APIServiceProtocol
    
    // MARK: - Accessor
    
    // MARK: - Outlet
    
    // MARK: - Action
    
    // MARK: - Constructor
    
    init(aPIService: APIServiceProtocol = ExchangeRateAPIService()) {
        self.aPIService = aPIService
    }
    
    // MARK: - Life Cycle
    deinit {
        print("shun - \( type(of: self) ) deinit")
    }
    
    // MARK: - Private Func
    private func removeFile(url: URL){
        if FileManager.default.fileExists(atPath: url.path){
            try! FileManager.default.removeItem(at: url)
            print("File URL removed:\n \( url.path)")
        }
    }
    
    private func parseJSON(rawData: Any)->[String:[ExchangeRateM]]{
        var result = [String:[ExchangeRateM]]()
        
        if let jsonArray = rawData as? [Any]{
            for item in jsonArray{
                var models = [ExchangeRateM]()
                if let jsonObject = item as? [String:String]{
                    var date = ""
                    for (key, value) in jsonObject {
                        var model = ExchangeRateM()
                        if key == "日期"{
                            date = value
                        }else{
                            model.name = key
                            model.rate = value
                            models.append(model)
                        }
                    }
                    result[date] = models
                }
            }
            
            print("jsonArray count: \(jsonArray.count) , result count: \(result.count)")
            //print("result: \(result)")
        }
        return result
    }
    
    private func getMockImageURL(rateName: String) -> String{
        let rateNameArray = rateName.split(separator: "／")
        
        var flagName = ""
        
        if rateNameArray[1].contains("新台幣") {
            flagName = String(rateNameArray[0])
        }else if rateNameArray[0].contains("美元"){
            flagName = String(rateNameArray[1])
        }else if rateNameArray[1].contains("美元"){
            flagName = String(rateNameArray[0])
        }else{
            fatalError("Unexpected Error")
        }
        
        return getNameToFlagImageName(flagName:flagName)
    }
    
    private func getNameToFlagImageName(flagName: String) -> String{
        switch flagName {
        case "美元":
            return "USD"
        case "人民幣":
            return "CNY"
        case "南非幣":
            return "ZAR"
        case "英鎊":
            return "GBP"
        case "歐元":
            return "EUR"
        case "澳幣":
            return "AUD"
        case "港幣":
            return "HKD"
        case "紐幣":
            return "NZD"
        case "日幣":
            return "JPY"
        default:
            fatalError("Unexpected flag name")
        }
    }
    
    private func buildViewModels(rawData: [String:[ExchangeRateM]]) -> [ExchangeRateListSectionVM]{
        // sort
        let sortedDatas = rawData.keys.sorted(by: dateStringDescComparator())
        // build
        return sortedDatas.map {
            let rowVMs = rawData[$0]!.map {
                
                return ExchangeRateListCellVM.init(model: $0, image:    AsyncImage.init(url:self.getMockImageURL(rateName: $0.name)))
            }
            return ExchangeRateListSectionVM.init(rowVMs: rowVMs, headerTitle: $0)
        }
    }
    
    private func dateStringDescComparator() -> ((String, String) -> Bool) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return { (d1Str, d2Str) -> Bool in
            if let d1 = formatter.date(from: d1Str),
                let d2 = formatter.date(from: d2Str) {
                return d1.compare(d2) == .orderedDescending
            } else {
                return false
            }
        }
    }
    
    // MARK: - Public Func
    
    func fetchExchangeRateListSectionVMs(complete: @escaping (_ vms: [ExchangeRateListSectionVM], _ errorMessage: String? ) -> Void) {
        
        DispatchQueue.global().async {
    
            self.aPIService.fetchDownloadDatas?(complete: {
                [weak self] (data, destinationURL, errorMsg)  in
                // fake response time
                sleep(3)
                var result = [ExchangeRateListSectionVM]()
                var errMsg: String? = nil
                
                if let _errorMsg = errorMsg{
                    errMsg = _errorMsg
                }else{
                    if let _data = data {
                        do {

                            let jsonData = try JSONSerialization.jsonObject(with: _data , options: JSONSerialization.ReadingOptions.allowFragments)
                            if let parsedResult = self?.parseJSON(rawData: jsonData),
                                let vms = self?.buildViewModels(rawData: parsedResult){
                                result = vms
                            }
                        }
                        catch {
                            errMsg = error.localizedDescription
                        }
                    }else{
                        errMsg = " data is nil "
                    }
                }
                
                if let fileUrl = destinationURL{
                    self?.removeFile(url: fileUrl)
                }
                
                DispatchQueue.main.async {
                    print("fetchExchangeRateListSectionVMs count: \(result.count)")
                    complete(result,errMsg)
                }
            })
        }
    }
}
