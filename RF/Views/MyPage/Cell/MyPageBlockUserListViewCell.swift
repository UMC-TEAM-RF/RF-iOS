//
//  MyPageBlockUserListViewCell.swift
//  RF
//
//  Created by 용용이 on 2023/10/10.
//

import UIKit

class MyPageBlockUserListViewCell: UITableViewCell {
    
    // MARK: - UI Property
    
    private lazy var profileView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 10 // 원하는 코너 반경 설정
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        return view
    }()
    
    private lazy var topStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .leading
        sv.spacing = 10
        return sv
    }()
    
    // 채팅방 이름
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = TextColor.first.color
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var userInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = TextColor.secondary.color
        label.numberOfLines = 2
        
        // 공간이 부족할 시 크기 줄어듦
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var blockButton: UIButton = {
        let button = UIButton()
        button.setTitle("차단", for: .normal)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.setTitle("차단 해제", for: .selected)
        button.setTitleColor(TextColor.secondary.color, for: .selected)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.backgroundColor = ButtonColor.normal.color
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    
    
    // MARK: - Property
    
    static let identifier = "MyPageBlockUserListViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        configureConstraints()
        
        let view = UIView()
        view.backgroundColor = BackgroundColor.dark.color
        self.selectedBackgroundView = view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        addSubview(profileView)
        
        addSubview(userNameLabel)
        addSubview(userInfoLabel)
        
        addSubview(blockButton)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        profileView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(profileView.snp.height)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileView.snp.trailing).offset(15)
            make.top.equalTo(profileView.snp.top).offset(5)
            make.trailing.equalTo(blockButton.snp.leading).offset(-10)
        }
        
        userInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(5)
            make.leading.equalTo(userNameLabel.snp.leading)
            make.trailing.equalTo(blockButton.snp.leading).offset(-10)
        }
        
        blockButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(80)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    func updateUserView(_ user: User) {
        userNameLabel.text = user.nickname
        userInfoLabel.text = "\(user.university ?? "")|\(user.entrance ?? 0)학번"
        if let url = URL(string: user.profileImageUrl ?? ""){
            profileView.load(url: url)
        }
        else{
            profileView.image = UIImage(named: "LogoImage")
        }
    }
}


