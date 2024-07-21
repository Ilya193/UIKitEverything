//
//  MessageView.swift
//  SwEverything
//
//  Created by ilya on 07.07.2024.
//

import UIKit

class MessageView: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "nissan_400z.jpg")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(image)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            image.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(title: String, body: String) {
        titleLabel.text = title
        bodyLabel.text = body
    }
    
}
