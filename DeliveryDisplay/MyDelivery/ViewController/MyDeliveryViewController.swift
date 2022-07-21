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
        viewModel.loadData { [weak self] (isSuccess, error) in
            DispatchQueue.main.async {
                isSuccess ? self?.tableView.reloadData() : self?.showAlert(message: error ?? "")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: MyDeliveryTableViewCell.identifier, for: indexPath) as? MyDeliveryTableViewCell {
            cell.configure(viewModel.cellAt(indexPath))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCell(at: indexPath)
    }
}

extension MyDeliveryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height) {
            self.tableView.tableFooterView = createSpinnerFooter()
            viewModel.fetchDeliveryList(isPagination: true) { [weak self] (isSuccess, error) in
                DispatchQueue.main.async {
                    isSuccess ? self?.tableView.reloadData() : self?.showAlert(message: error ?? "")
                }
            }
        }
    }
}

private extension MyDeliveryViewController {
    func setupComponents() {
        self.navigationItem.title = Constants.MyDelivery.myDeliveryTitle
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func showAlert(message: String) {
        let okButton = UIAlertAction(title: Constants.MyDelivery.alertBtnTitle, style: .cancel, handler: nil)
        let alert = UIAlertController(title: Constants.MyDelivery.alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

