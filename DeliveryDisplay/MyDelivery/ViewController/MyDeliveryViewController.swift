//
//  MyDeliveryViewController.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/16.
//

import UIKit

final class MyDeliveryViewController: UIViewController {
    private let viewModel: MyDeliveryViewModelProtocol
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.register(MyDeliveryTableViewCell.self,
                           forCellReuseIdentifier: MyDeliveryTableViewCell.identifier)
        return tableView
    }()
    
    init(viewModel: MyDeliveryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        viewModel.fetchDeliveryList { [weak self] (isSuccess, error) in
            DispatchQueue.main.async {
                isSuccess ? self?.tableView.reloadData() : self?.showAlert(message: error ?? "")
            }
        }
    }
    
    
}

extension MyDeliveryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MyDeliveryTableViewCell.identifier, for: indexPath) as? MyDeliveryTableViewCell,
           let cModel = viewModel.cellAt(indexPath) {
            cell.configure(cModel)
            
            return cell
        }
        
        return UITableViewCell()
    }
}

private extension MyDeliveryViewController {
    func setupComponents() {
        self.navigationItem.title = Constants.MyDelivery.myDeliveryTitle
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func showAlert(message: String) {
        let okButton = UIAlertAction(title: Constants.MyDelivery.alertBtnTitle, style: .cancel, handler: nil)
        let alert = UIAlertController(title: Constants.MyDelivery.alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

