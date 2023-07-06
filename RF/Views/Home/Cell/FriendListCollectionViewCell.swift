//
//  FriendListCollectionViewCell.swift
//  RF
//
//  Created by 이정동 on 2023/07/05.
//

import UIKit
import SnapKit

class FriendListCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person")
        view.contentMode = .scaleAspectFill
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemGray6
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(schoolLabel)
        contentView.addSubview(subjectLabel)
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.right.equalToSuperview().inset(30)
            
            make.height.equalTo(imageView.snp.width).multipliedBy(1)
        }
        
        schoolLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(15)
        }
        
        subjectLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(schoolLabel.snp.bottom).offset(8)
            //make.bottom.equalToSuperview().inset(15)
        }
    }
}
