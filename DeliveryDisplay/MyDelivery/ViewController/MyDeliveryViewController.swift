//
//  MyDeliveryViewController.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/16.
//

import UIKit

final class MyDeliveryViewController: UIViewController {
    private let viewModel: MyDeliveryViewModelProtocol
    
    init(viewModel: MyDeliveryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        viewModel.fetchDeliveryList {
            
        }
    }
    
    
}

extension MyDeliveryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}

private extension MyDeliveryViewController {
    func setupTableView() {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

