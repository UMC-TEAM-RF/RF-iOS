//
//  TagCollectionViewCell.swift
//  RF
//
//  Created by 이정동 on 2023/07/07.
//

import UIKit
import SnapKit

class TagCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        //label.text = "#미대"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.textColor = TextColor.first.color
        return label
    }()
    
    // MARK: - Property
    
    static let identifier = "TagCollectionViewCell"
    
    var isSelectedCell: Bool = false {
        didSet {
            isSelectedCell ?
            setColor(textColor: .white, backgroundColor: .tintColor) : setColor(textColor: .black, backgroundColor: .systemGray6)
        }
    }
    
    // MARK: - init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor(white: 1, alpha: 0.75)
        contentView.layer.cornerRadius = contentView.frame.height / 2
        
        addSubviews()
        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        contentView.addSubview(tagLabel)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        tagLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTagLabel(_ text: String) {
        tagLabel.text = text
    }
    
    func setCellBackgroundColor(_ color: UIColor) {
        contentView.backgroundColor = color
    }
    
    func setColor(textColor: UIColor, backgroundColor: UIColor) {
        self.tagLabel.textColor = textColor
        self.contentView.backgroundColor = backgroundColor
    }
}
