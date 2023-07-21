//
//  InterestSmallCollectionViewCell.swift
//  RF
//
//  Created by 용용이 on 2023/07/21.
//

import UIKit

class InterestSmallCollectionViewCell: UICollectionViewCell {
    
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
        contentView.addSubview(textLabel)
    }
    
    private func configureConstraints() {
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setTextLabel(_ text: String) {
        self.textLabel.text = text
    }
    
    func setCornerRadius() {
        layoutIfNeeded()
        contentView.layer.cornerRadius = (contentView.frame.width + contentView.frame.height) / 8
    }
    
    func setColor(textColor: UIColor, backgroundColor: UIColor) {
        self.textLabel.textColor = textColor
        self.contentView.backgroundColor = backgroundColor
    }
}
