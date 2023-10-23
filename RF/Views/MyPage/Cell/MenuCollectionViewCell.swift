//
//  menuCollectionViewCell.swift
//  RF
//
//  Created by 용용이 on 2023/10/07.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descriptLabel: UILabel = {
        let label = UILabel()
        label.text = "상세설명"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = TextColor.secondary.color
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var rightButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.right")?.resize(newWidth: 10), for: .normal)
        btn.tintColor = TextColor.secondary.color
        return btn
    }()
    
    var varTitleLabel: String? {
        didSet {
            self.titleLabel.text = varTitleLabel
        }
    }
    var varDescriptLabel: String? {
        didSet {
            self.descriptLabel.text = varDescriptLabel
        }
    }
    
    static let identifier = "menuCollectionViewCell"
    
    // MARK: - init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = TextColor.secondary.color.cgColor
        contentView.layer.cornerRadius = 10
        //Corner radius 적용을 위한 코드
        contentView.clipsToBounds = true
        
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptLabel)
        contentView.addSubview(rightButton)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15)
        }
        
        rightButton.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(15)
        }
        
        descriptLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.trailing.equalTo(rightButton.snp.leading).offset(-15)
        }
        
    }
}
