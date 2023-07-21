//
//  FriendListCollectionViewCell.swift
//  RF
//
//  Created by 이정동 on 2023/07/05.
//

import UIKit
import SnapKit

class FriendListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var schoolLabel: UILabel = {
        let label = UILabel()
        label.text = "ERIKA 🇰🇷"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private lazy var subjectLabel: UILabel = {
        let label = UILabel()
        label.text = "컴퓨터공학과"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    // MARK: - Property
    
    static let identifier = "FriendListCollectionViewCell"
    
    // MARK: - init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 10
        
        addSubviews()
        configureConstraints()
        
        layoutIfNeeded()
        imageView.layer.cornerRadius = imageView.bounds.width / 2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(schoolLabel)
        contentView.addSubview(subjectLabel)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.trailing.equalToSuperview().inset(25)
            
            make.height.equalTo(imageView.snp.width).multipliedBy(1)
        }
        
        schoolLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(15)
        }
        
        subjectLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(schoolLabel.snp.bottom).offset(5)
            //make.bottom.equalToSuperview().inset(15)
        }
    }
}
