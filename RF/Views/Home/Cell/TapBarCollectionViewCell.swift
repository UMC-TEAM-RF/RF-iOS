//
//  TapBarCollectionViewCell.swift
//  RF
//
//  Created by 용용이 on 2023/08/20.
//

import UIKit


class TapBarCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    // MARK: - Property
    
    static let identifier = "TapBarCollectionViewCell"
    
    // MARK: - init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        contentView.addSubview(textLabel)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setTextLabel(_ text: String) {
        self.textLabel.text = text
    }
        
    func setColor(textColor: UIColor, backgroundColor: UIColor) {
        self.textLabel.textColor = textColor
        self.contentView.backgroundColor = backgroundColor
    }
}
