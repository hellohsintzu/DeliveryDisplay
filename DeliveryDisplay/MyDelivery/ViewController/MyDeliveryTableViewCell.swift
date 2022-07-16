//
//  MyDeliveryTableViewCell.swift
//  DeliveryDisplay
//
//  Created by 顏莘慈 on 2022/7/16.
//

import UIKit

final class MyDeliveryTableViewCell: UITableViewCell {
    static let identifier = "MyDeliveryTableViewCell"
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .orange
        contentView.addSubview(image)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        image.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
    }
    
    func configure(_ cModel: DeliveryDetails) {
        label.text = cModel.sender?.name ?? ""
        image.load(url: URL(string: cModel.goodsPicture ?? ""))
    }
}
