//
//  ExchangeRateListCellVM.swift
//  ExchangeRateDemo
//
//  Created by Shun on 2018/7/24.
//  Copyright © 2018年 com.shun.demo. All rights reserved.
//

import Foundation


class ExchangeRateListCellVM: ExchangeRateListRowVM {

    // MARK: - Type Alias
    
    // MARK: - Property
    let model: ExchangeRateM
    var image: AsyncImage
    
    // MARK: - Accessor
    
    // MARK: - Outlet
    
    // MARK: - Action
    
    // MARK: - Constructor
    init(model: ExchangeRateM, image: AsyncImage) {
        self.model = model
        self.image = image
    }
    // MARK: - Life Cycle
    deinit {
        print("shun - \( type(of: self) ) deinit")
    }
    
    // MARK: - Private Func
    
    // MARK: - Public Func
    
}
