//
//  DeliveryDetailViewController.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/17.
//

import UIKit
import SDWebImage

final class DeliveryDetailViewController: UIViewController {
    private let viewModel: DeliveryDetailViewModelProtocol
    
    private let rootView = UIView()
    private let routeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 0.5)
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        return view
    }()
    
    private let goodsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 0.5)
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        return view
    }()
    
    private let feeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 0.5)
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        return view
    }()
    
    private let favButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.DeliveryDetail.favBtnTitle, for: .normal)
        button.titleLabel?.textColor = .darkGray
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.addTarget(self, action: #selector(favButtonDidTap), for: .touchUpInside)
        button.backgroundColor = .orange
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.imageView?.tintColor = .white
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        return button
    }()
    
    private let fromLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Constants.MyDelivery.senderLabel)"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    private let toLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Constants.MyDelivery.receiverLabel)"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    private let senderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    private let receiverLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    private let goodsLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Constants.DeliveryDetail.goodsTitle)"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    private let deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Constants.DeliveryDetail.feeTitle)"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    private let feeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    private let goodsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    init(viewModel: DeliveryDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupValues()
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubViews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupFrames()
    }
}

private extension DeliveryDetailViewController {
    @objc func favButtonDidTap() {
        favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favButton.imageView?.tintColor = .white
    }
    
    func setupValues() {
        senderLabel.text = viewModel.senderLabelTitle
        receiverLabel.text = viewModel.receiverLabelTitle
        goodsImageView.sd_setImage(with: URL(string: viewModel.imageURLString))
        feeLabel.text = viewModel.deliveryFeeString
    }
    
    func setupSubViews() {
        view.addSubview(rootView)
        view.addSubview(routeView)
        view.addSubview(goodsView)
        view.addSubview(feeView)
        view.addSubview(favButton)
        view.addSubview(fromLabel)
        view.addSubview(toLabel)
        view.addSubview(senderLabel)
        view.addSubview(receiverLabel)
        view.addSubview(goodsLabel)
        view.addSubview(deliveryLabel)
        view.addSubview(goodsImageView)
        view.addSubview(feeLabel)
    }
    
    func setupFrames() {
        rootView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        routeView.frame = CGRect(x: 10, y: 100, width: view.frame.size.width-20, height: 80)
        fromLabel.frame = CGRect(x: 30, y: 110, width: (view.frame.size.width/3)-30, height: 30)
        senderLabel.frame = CGRect(x: view.frame.size.width/3, y: 110, width: view.frame.size.width/2, height: 30)
        toLabel.frame = CGRect(x: 30, y: 140, width: (view.frame.size.width/3)-30, height: 30)
        receiverLabel.frame = CGRect(x: view.frame.size.width/3, y: 140, width: view.frame.size.width/2, height: 30)
        
        goodsView.frame = CGRect(x: 10, y: 200, width: view.frame.size.width-20, height: 220)
        goodsLabel.frame = CGRect(x: 30, y: 210, width: view.frame.size.width-50, height: 30)
        goodsImageView.frame = CGRect(x: 30, y: 250, width: 150, height: 150)
        
        feeView.frame = CGRect(x: 10, y: 440, width: view.frame.size.width-20, height: 60)
        deliveryLabel.frame = CGRect(x: 30, y: 455, width: (view.frame.size.width/2)-50, height: 30)
        feeLabel.frame = CGRect(x: view.frame.size.width/2, y: 455, width: (view.frame.size.width/2)-50, height: 30)
        
        favButton.frame = CGRect(x: 20, y: view.frame.size.height-70, width: view.frame.size.width-40, height: 40)
        
    }
}
