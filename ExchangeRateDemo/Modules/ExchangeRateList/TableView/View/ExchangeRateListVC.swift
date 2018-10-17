//
//  ExchangeRateListVC.swift
//  ExchangeRateDemo
//
//  Created by Shun on 2018/7/24.
//  Copyright © 2018年 com.shun.demo. All rights reserved.
//

import UIKit

class ExchangeRateListVC: UIViewController {
    // MARK: - Type Alias
    
    // MARK: - Property
    
    lazy var presenter: ExchangeRateListP = {
        return ExchangeRateListP()
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.allowsSelection = true
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate(tableView.edgeConstraints(top: 80, left: 0, bottom: 0, right: 0))
        
        tableView.register(ExchangeRateListCell.self, forCellReuseIdentifier: ExchangeRateListCell.cellIdentifier())
        return tableView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
            ])
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 24.0)
        return label
    }()
    
    lazy var loadingIdicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        return indicator
    }()
    
    // MARK: - Accessor
    
    // MARK: - Outlet
    
    // MARK: - Action
    
    // MARK: - Constructor
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initBinding()
        // Fetch Data
        self.presenter.start()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("shun - \( type(of: self) ) deinit")
    }
    
    // MARK: - Private Func
    private func initView(){
        self.view.backgroundColor = .white
        
    }
    
    private func initBinding(){
        self.presenter.viewModel.sectionVMs.addObserver(fireNow: false) {
            [weak self] (sectionViewModels) in
            self?.tableView.reloadData()
        }
        
        self.presenter.viewModel.title.addObserver { [weak self] (title) in
            self?.titleLabel.text = title
        }
        
        self.presenter.viewModel.isTableViewHidden.addObserver { [weak self] (isHidden) in
            self?.tableView.isHidden = isHidden
        }
        
        self.presenter.viewModel.isLoading.addObserver { [weak self] (isLoading) in
            self?.tableView.isHidden = isLoading
            if isLoading {
                self?.loadingIdicator.startAnimating()
            } else {
                self?.loadingIdicator.stopAnimating()
            }
        }
        
        self.presenter.viewModel.alertMessage.addObserver {
            [weak self] (msg) in
            DispatchQueue.main.async {
                if let message = msg {
                    self?.showAlert(message)
                }
            }
        }
    }
    
    private func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Public Func
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// MARK: - Extension

// MARK: - UITableViewDelegate
extension ExchangeRateListVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ExchangeRateListSectionHeaderView()
        let sectionVM = self.presenter.viewModel.sectionVMs.value[section]
        view.setTitle(sectionVM.headerTitle)
        return view
    }

}


// MARK: - UITableViewDataSource
extension ExchangeRateListVC: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        // Section Count
        return self.presenter.viewModel.sectionVMs.value.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Get Section
        let sectionVM = self.presenter.viewModel.sectionVMs.value[section]
        // row count
        return sectionVM.rowVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionVM = self.presenter.viewModel.sectionVMs.value[indexPath.section]
        let rowVM = sectionVM.rowVMs[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.presenter.cellIdentifier(for: rowVM), for: indexPath)
   
        if let cell = cell as? ExchangeRateListCellConfiguraable {
            cell.setup(viewModel: rowVM)
        }
        
        return cell
    }
    
}
