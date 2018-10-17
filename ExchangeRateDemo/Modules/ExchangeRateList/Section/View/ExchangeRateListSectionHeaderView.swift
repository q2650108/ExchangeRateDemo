//
//  ExchangeRateListSectionHeaderView.swift
//  ExchangeRateDemo
//
//  Created by Shun on 2018/7/25.
//  Copyright © 2018年 com.shun.demo. All rights reserved.
//

import UIKit

class ExchangeRateListSectionHeaderView: UIView {
    // MARK: - Type Alias
    
    // MARK: - Property
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.font =  UIFont.systemFont(ofSize: 17.0)
        label.textColor = UIColor.gray
        return label
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    // MARK: - Accessor
    public func setTitle(_ text: String) {
        self.titleLabel.text = text
    }
    // MARK: - Outlet
    
    // MARK: - Action
    
    // MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialView()
        setupConstrint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    deinit {
        print("shun - \( type(of: self) ) deinit")
    }
    
    // MARK: - Private Func
    private func setupInitialView() {
        self.backgroundColor = UIColor.white
    }
    
    private func setupConstrint() {
        
        NSLayoutConstraint.activate(self.titleLabel.edgeConstraints(top: 5, left: 10, bottom: 5, right: 10))

        NSLayoutConstraint.activate([
            self.separator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.separator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            self.separator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
            self.separator.heightAnchor.constraint(equalToConstant: 1)
            ])
    }
    
    // MARK: - Public Func
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
