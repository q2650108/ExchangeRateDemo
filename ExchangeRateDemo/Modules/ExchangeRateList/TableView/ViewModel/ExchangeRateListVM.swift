//
//  ExchangeRateListVM.swift
//  ExchangeRateDemo
//
//  Created by Shun on 2018/7/24.
//  Copyright © 2018年 com.shun.demo. All rights reserved.
//

import Foundation

class ExchangeRateListVM {
    // MARK: - Type Alias
    
    // MARK: - Property
    
    let title = Observable<String>(value: "Loading")
    
    let isLoading = Observable<Bool>(value: false)
    
    let isTableViewHidden = Observable<Bool>(value: false)
    
    let sectionVMs = Observable<[ExchangeRateListSectionVM]>(value: [])
    
    let alertMessage = Observable<String?>(value: nil)
    
    
    // MARK: - Accessor
    
    // MARK: - Outlet
    
    // MARK: - Action
    
    // MARK: - Constructor

    // MARK: - Life Cycle
    deinit {
        print("shun - \( type(of: self) ) deinit")
    }
    
    // MARK: - Private Func
    
    // MARK: - Public Func
    
}
