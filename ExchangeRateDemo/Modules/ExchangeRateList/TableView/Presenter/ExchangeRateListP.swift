//
//  ExchangeRateListP.swift
//  ExchangeRateDemo
//
//  Created by Shun on 2018/7/24.
//  Copyright © 2018年 com.shun.demo. All rights reserved.
//

import UIKit

class ExchangeRateListP {
    // MARK: - Type Alias
    
    // MARK: - Property
    let viewModel: ExchangeRateListVM
    
    let service: ExchangeRateService

    
    // MARK: - Accessor
    
    // MARK: - Outlet
    
    // MARK: - Action
    
    // MARK: - Constructor
    init(viewModel: ExchangeRateListVM = ExchangeRateListVM(),
         service: ExchangeRateService = ExchangeRateService()) {
        self.viewModel = viewModel
        self.service = service
    }
    
    // MARK: - Life Cycle
    deinit {
        print("shun - \( type(of: self) ) deinit")
    }
    
    // MARK: - Private Func
    
    // MARK: - Public Func
    func start() {
        self.viewModel.isLoading.value = true
        self.viewModel.isTableViewHidden.value = true
        self.viewModel.title.value = "Loading ..."
        
        self.service.fetchExchangeRateListSectionVMs(complete: {
            [weak self](exchangeRateListSectionVMs, errMsg) in
            
            self?.viewModel.isLoading.value = false
            
            if let _errMsg = errMsg {
                self?.viewModel.alertMessage.value = _errMsg
                return
            }
            
            self?.viewModel.title.value = "Exchange Rate"
            self?.viewModel.isTableViewHidden.value = false
            self?.viewModel.sectionVMs.value = exchangeRateListSectionVMs
        })
        
    }
    
    func cellIdentifier(for viewModel: ExchangeRateListRowVM) -> String {
        switch viewModel {
        case is ExchangeRateListCellVM:
            return ExchangeRateListCell.cellIdentifier()
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
    }
}
