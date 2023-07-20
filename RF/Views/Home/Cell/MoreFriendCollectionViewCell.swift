//
//  MoreFriendCollectionViewCell.swift
//  RF
//
//  Created by 이정동 on 2023/07/07.
//

import UIKit
import SnapKit

class MoreFriendCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "plus")
        image.tintColor = .lightGray
        
        image.backgroundColor = .white
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "더보기"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Property
    
    static let identifier = "MoreFriendCollectionViewCell"
    
    // MARK: - init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 10
        
        addSubviews()
        configureConstraints()
        
        layoutIfNeeded()
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(27)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(imageView.snp.width).multipliedBy(1)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
}
