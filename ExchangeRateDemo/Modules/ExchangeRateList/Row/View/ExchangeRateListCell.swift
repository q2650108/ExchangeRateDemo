//
//  ExchangeRateListCell.swift
//  ExchangeRateDemo
//
//  Created by Shun on 2018/7/24.
//  Copyright © 2018年 com.shun.demo. All rights reserved.
//

import UIKit

class ExchangeRateListCell: UITableViewCell {
    // MARK: - Type Alias
    
    // MARK: - Property
    var viewModel: ExchangeRateListCellVM?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.text = "title"
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = "value"
        return label
    }()
    
    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageView)
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 3
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Accessor
    
    // MARK: - Outlet
    
    // MARK: - Action
    
    // MARK: - Constructor
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInitialView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInitialView()
        setupConstraints()
    }
    
    // MARK: - Life Cycle
    deinit {
        print("shun - \( type(of: self) ) deinit")
    }
    
    // MARK: - Private Func
    
    private func setupInitialView() {
        self.selectionStyle = .none
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).withPriority(priority: .defaultLow),
            coverImageView.heightAnchor.constraint(equalToConstant: 30),
            coverImageView.widthAnchor.constraint(equalToConstant: 50),
            
            titleLabel.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 20),
            
            valueLabel.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor, constant: 0),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
            ])
        
    }
    // MARK: - Public Func
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel?.image.completeDownload = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
}
// MARK: - ExchangeRateListCellConfiguraable
extension ExchangeRateListCell: ExchangeRateListCellConfiguraable{
    
    func setup(viewModel: ExchangeRateListRowVM) {
        guard let viewModel = viewModel as? ExchangeRateListCellVM else {
            return
        }
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.model.name
        self.valueLabel.text = viewModel.model.rate
        self.coverImageView.image = viewModel.image.image
        
        viewModel.image.startDownload()
        viewModel.image.completeDownload = {
            [weak self] image in
            self?.coverImageView.image = image
        }
    }
}
