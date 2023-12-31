//
//  LanguageTableViewCell.swift
//  RF
//
//  Created by 용용이 on 2023/10/16.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {
    
    // MARK: - UI Property
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = TextColor.first.color
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    // MARK: - Property
    
    static let identifier = "LanguageTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        addSubview(label)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            
        }
    }
    
    func updateTitle(_ txt: String) {
        label.text = txt
    }
    func updateColor(_ color: UIColor) {
        label.textColor = color
    }
}


