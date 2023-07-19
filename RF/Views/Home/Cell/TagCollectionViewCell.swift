//
//  TagCollectionViewCell.swift
//  RF
//
//  Created by 이정동 on 2023/07/07.
//

import UIKit
import SnapKit

class TagCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TagCollectionViewCell"
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        //label.text = "#미대"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = contentView.frame.height / 2
        
        addSubviews()
        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubviews() {
        contentView.addSubview(tagLabel)
    }
    
    private func configureConstraints() {
        tagLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTagLabel(_ text: String) {
        tagLabel.text = "#\(text)"
    }
}
