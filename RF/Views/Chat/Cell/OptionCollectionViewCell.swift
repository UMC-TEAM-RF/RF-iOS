//
//  OptionCollectionViewCell.swift
//  RF
//
//  Created by 이정동 on 2023/08/05.
//

import UIKit
import SnapKit

class OptionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "LogoImage")
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .lightGray
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.text = "사진"
        label.textColor = .black
        return label
    }()
    
    static let identifier = "OptionCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureConstraints()
        
        contentView.layoutIfNeeded()
        imageView.layer.cornerRadius = imageView.frame.width / 2.0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(imageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
}
