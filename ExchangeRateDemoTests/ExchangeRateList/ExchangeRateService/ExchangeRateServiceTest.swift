//
//  ExchangeRateServiceTest.swift
//  ExchangeRateDemoTests
//
//  Created by Shun on 2018/8/1.
//  Copyright © 2018年 com.shun.demo. All rights reserved.
//

import XCTest
@testable import ExchangeRateDemo


class ExchangeRateServiceTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_fetchExchangeRateListSectionVMs_success() {

        let mockExchangeRateAPIService =  MockExchangeRateAPIService.init()
        mockExchangeRateAPIService.setIsDataNeedError(isDataNeedError: false)
        let sut = ExchangeRateService.init(aPIService: mockExchangeRateAPIService)
        
        let expect = XCTestExpectation(description: "test_fetchExchangeRateListSectionVMs_success XCTestExpectation")
        
        sut.fetchExchangeRateListSectionVMs {
            (exchangeRateListSectionVMs, errorMessage) in
            expect.fulfill()
            XCTAssertEqual(exchangeRateListSectionVMs.count, 26)
            for exchangeRateListSectionVM in exchangeRateListSectionVMs {
                XCTAssertNotNil( exchangeRateListSectionVM.rowVMs)
            }
        }

        wait(for: [expect], timeout: 15.0)
    }
    
    func test_fetchExchangeRateListSectionVMs_fail() {
        
        let mockExchangeRateAPIService =  MockExchangeRateAPIService.init()
        mockExchangeRateAPIService.setIsDataNeedError(isDataNeedError: true)
        let sut = ExchangeRateService.init(aPIService: mockExchangeRateAPIService)
        
        let expect = XCTestExpectation(description: "test_fetchExchangeRateListSectionVMs_fail XCTestExpectation")
        
        sut.fetchExchangeRateListSectionVMs {
            (exchangeRateListSectionVMs, errorMessage) in
            expect.fulfill()
            XCTAssertNotNil(errorMessage)
        }
        
        wait(for: [expect], timeout: 15.0)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
