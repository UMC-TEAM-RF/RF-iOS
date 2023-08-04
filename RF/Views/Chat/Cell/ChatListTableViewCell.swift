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
    
    // 채팅방 이미지
    private lazy var profileView: ProfileUIView = {
        let view = ProfileUIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // 채팅방 이름
    private lazy var chatTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexCode: "3C3A3A")
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    // 인원
    private lazy var personnelLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .lightGray
        label.text = "7"
        return label
    }()
    
    // 시간
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .lightGray
        label.text = "오후 4:04"
        return label
    }()
    
    
    
    // MARK: - Property
    
    static let identifier = "ChatListTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        addSubview(profileView)
        addSubview(chatTitleLabel)
        addSubview(personnelLabel)
        addSubview(timeLabel)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        profileView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(profileView.snp.height)
        }
        
        chatTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileView.snp.trailing).offset(15)
            make.top.equalTo(profileView.snp.top).offset(5)
        }
        
        personnelLabel.snp.makeConstraints { make in
            make.leading.equalTo(chatTitleLabel.snp.trailing).offset(10)
            make.centerY.equalTo(chatTitleLabel.snp.centerY)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(chatTitleLabel.snp.centerY)
        }
    }
    
    func inputData(imageList: [String?]?, meetingName: String?){
        addSubviews()
        
        guard let imageList = imageList,
              let meetingName = meetingName else { return }
        
        chatTitleLabel.text = meetingName
        profileView.inputData(imgList: imageList)
    }
}
