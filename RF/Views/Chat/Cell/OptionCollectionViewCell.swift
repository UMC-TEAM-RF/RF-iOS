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
        iv.image = UIImage(named: "LogoImage")?.resize(newWidth: 20, newHeight: 20)
        iv.contentMode = .center
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
    
    func configureOptionUI(_ option: ChatMenuOption?) {
        guard let option else { print("return"); return }
        switch option {
        case .album:
            configureUIView(image: UIImage(named: "album"), title: "사진", color: .tintColor)
        case .camera:
            configureUIView(image: UIImage(named: "camera"), title: "카메라", color: .green)
        case .schedule:
            configureUIView(image: UIImage(named: "schedule"), title: "일정", color: .cyan)
        case .keyword:
            configureUIView(image: UIImage(named: "keyword"), title: "키워드", color: .systemBlue)
        case .subject:
            configureUIView(image: UIImage(named: "subject"), title: "주제", color: .systemIndigo)
        }
    }
    
    private func configureUIView(image: UIImage?, title: String, color: UIColor) {
        self.imageView.image = image
        self.titleLabel.text = title
        self.imageView.backgroundColor = color
    }
}
