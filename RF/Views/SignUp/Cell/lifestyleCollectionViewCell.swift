//
//  lifestyleCollectionViewCell.swift
//  RF
//
//  Created by 용용이 on 2023/08/04.
//

import UIKit

class lifestyleCollectionViewCell: UICollectionViewCell {
    
    // 로고 이미지
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    var isSelectedCell: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(8)
        }
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }
    func setImage(_ named: String) {
        self.imageView.image = UIImage(named: named)?.resize(newWidth: 117.38)
    }
    
    func setTextLabel(_ text: String) {
        self.textLabel.text = text
    }
    
    func setCornerRadius() {
        layoutIfNeeded()
        contentView.layer.cornerRadius = contentView.frame.height / 6
    }
    
    func setColor(textColor: UIColor, backgroundColor: UIColor) {
        self.textLabel.textColor = textColor
        self.contentView.backgroundColor = backgroundColor
    }
}
