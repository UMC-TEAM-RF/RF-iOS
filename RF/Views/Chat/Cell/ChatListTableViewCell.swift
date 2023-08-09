//
//  ChatListTableViewCell.swift
//  RF
//
//  Created by 이정동 on 2023/08/04.
//

import UIKit
import SnapKit

class ChatListTableViewCell: UITableViewCell {
    
    // MARK: - UI Property
    
    private lazy var profileView: GroupProfileView = {
        let view = GroupProfileView()
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
    private lazy var chatTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexCode: "3C3A3A")
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .lightGray
        label.numberOfLines = 2
        
        // 공간이 부족할 시 크기 줄어듦
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    // 인원
    private lazy var personnelLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .lightGray
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    // 시간
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .lightGray
        label.text = "오후 4:04"
        label.textAlignment = .right
        return label
    }()
    
    
    
    // MARK: - Property
    
    static let identifier = "ChatListTableViewCell"
    
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
        
        addSubview(topStackView)
        topStackView.addArrangedSubview(chatTitleLabel)
        topStackView.addArrangedSubview(personnelLabel)
        
        addSubview(contentLabel)
        addSubview(timeLabel)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        profileView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(profileView.snp.height)
        }
        
        topStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileView.snp.trailing).offset(15)
            make.top.equalTo(profileView.snp.top).offset(5)
            make.trailing.equalTo(timeLabel.snp.leading).offset(-10)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(chatTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(chatTitleLabel.snp.leading)
            make.trailing.equalTo(timeLabel.snp.leading).offset(-10)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(chatTitleLabel.snp.centerY)
        }
    }
    
    func updateChannelView(_ channel: Channel) {
        chatTitleLabel.text = channel.name
        personnelLabel.text = "\(channel.userProfileImages.count)"
        profileView.updateProfileImages(with: channel.userProfileImages)
        contentLabel.text = channel.messages.last?.content
        timeLabel.text = DateTimeFormatter.shared.convertStringToDateTime(channel.messages.last?.dateTime, isCompareCurrentTime: true)
    }
}


