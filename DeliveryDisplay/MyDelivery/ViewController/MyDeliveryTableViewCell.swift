//
//  MyDeliveryTableViewCell.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/16.
//

import UIKit
import SDWebImage

final class MyDeliveryTableViewCell: UITableViewCell {
    static let identifier = "MyDeliveryTableViewCell"
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
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
    
    private let feeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        return label
    }()
    
    private let favoriteIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .orange
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupFrames()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setValuesNil()
    }
    
    func configure(_ cModel: MyDeliveryModel) {
        senderLabel.text = "\(Constants.MyDelivery.senderLabel)\(cModel.senderTitle)"
        receiverLabel.text = "\(Constants.MyDelivery.receiverLabel)\(cModel.receiverTitle)"
        feeLabel.text = "\(Constants.MyDelivery.feeLabel)\(cModel.feeTitle)"
        cellImageView.sd_setImage(with: URL(string: cModel.imageURLString))
        favoriteIndicator.image = cModel.isFavorite ? UIImage(systemName: "heart.fill") : nil
    }
}

private extension MyDeliveryTableViewCell {
    func setupContentView() {
        contentView.addSubview(cellImageView)
        contentView.addSubview(senderLabel)
        contentView.addSubview(receiverLabel)
        contentView.addSubview(feeLabel)
        contentView.addSubview(favoriteIndicator)
    }
    
    func setupFrames() {
        let imagesize = contentView.frame.size.height-10
        cellImageView.frame = CGRect(x: contentView.frame.size.width-imagesize-5, y: 5, width: imagesize, height: imagesize)
        senderLabel.frame = CGRect(x: 10, y: 10, width: contentView.frame.size.width/2, height: contentView.frame.size.height/2)
        receiverLabel.frame = CGRect(x: 10, y: 35, width: contentView.frame.size.width/2, height: contentView.frame.size.height/2)
        feeLabel.frame = CGRect(x: contentView.frame.size.width/2, y: 35, width: contentView.frame.size.width, height: contentView.frame.size.height/2)
        favoriteIndicator.frame = CGRect(x: contentView.frame.size.width/2, y: 10, width: 20, height: 20)
    }
    
    func setValuesNil() {
        senderLabel.text = nil
        receiverLabel.text = nil
        feeLabel.text = nil
        cellImageView.image = nil
    }
}
