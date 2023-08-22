//
//  NotiListTableViewCell.swift
//  RF
//
//  Created by 이정동 on 2023/07/21.
//

import UIKit

class NotiListTableViewCell: UITableViewCell {
    
    // MARK: - UI Property
    
    private lazy var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "LogoImage")
        return iv
    }()
    
    private lazy var notiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = TextColor.first.color
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = TextColor.secondary.color
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Property
    
    static let identifier = "NotiListTableViewCell"
    
    var notiLabelText: String? {
        didSet {
            self.notiLabel.text = notiLabelText
        }
    }
    
    var timeLabelText: String? {
        didSet {
            self.timeLabel.text = timeLabelText
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        configureConstraints()
        
        selectionStyle = .none
        
        layoutIfNeeded()
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        contentView.addSubview(profileImage)
        contentView.addSubview(notiLabel)
        contentView.addSubview(timeLabel)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        profileImage.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(26)
            make.width.equalTo(profileImage.snp.height).multipliedBy(1)
        }
        
        notiLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(profileImage.snp.trailing).offset(8)
            make.trailing.equalTo(timeLabel.snp.leading).offset(-8)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(26)
            make.centerY.equalToSuperview()
            make.width.equalTo(45)
        }
    }

}
