//
//  MenuButton.swift
//  RF
//
//  Created by 이정동 on 2023/07/30.
//

import UIKit

class MenuButton: UIView {
    
    private lazy var downImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.down")
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        iv.tintColor = TextColor.first.color
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = TextColor.first.color
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        return label
    }()
    
    weak var delegate: MenuButtonDelegate?
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ButtonColor.normal.color
        
        self.isUserInteractionEnabled = true
        
        self.layer.cornerRadius = 10
        
        addSubviews()
        configureConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - addSubviews()
    
    private func addSubviews() {
        addSubview(downImage)
        addSubview(titleLabel)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        downImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(self.snp.height).multipliedBy(0.6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.trailing.equalTo(downImage.snp.leading).offset(-15)
            make.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
    }
    
    private func addTargets() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func buttonTapped() {
        delegate?.didTapMenuButton(self.tag)
    }
}
