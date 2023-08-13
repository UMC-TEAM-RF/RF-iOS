//
//  MyMessageTableViewCell.swift
//  iOS_Test
//
//  Created by 이정동 on 2023/07/28.
//

import UIKit

class MyMessageTableViewCell: UITableViewCell {
    
    static let identifier = "MyMessageTableViewCell"
    
    private lazy var messageView: UIView = {
        let view = UIView()
        view.backgroundColor = .tintColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping // 글자 단위로 줄바꿈
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "오후 7:15"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        configureConstraints()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - addSubviews()
    
    private func addSubviews() {
        
        contentView.addSubview(messageView)
        contentView.addSubview(timeLabel)
        
        messageView.addSubview(messageLabel)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        
        messageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(3)
            make.trailing.equalToSuperview().inset(8)
            
        }
        
        messageLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(5)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.65)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(messageView.snp.bottom)
            make.trailing.equalTo(messageView.snp.leading).offset(-3)
        }
        
    }
    
    func updateChatView(_ message: CustomMessage) {
        messageLabel.text = message.content
        timeLabel.text = DateTimeFormatter.shared.convertStringToDateTime(message.dateTime, isCompareCurrentTime: false)
    }
}

