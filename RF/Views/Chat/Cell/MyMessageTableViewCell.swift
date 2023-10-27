//
//  MyMessageTableViewCell.swift
//  iOS_Test
//
//  Created by 이정동 on 2023/07/28.
//

import UIKit

class MyMessageTableViewCell: UITableViewCell {
    
    static let identifier = "MyMessageTableViewCell"
    
    private lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.distribution = .fill
        view.alignment = .trailing
        return view
    }()
    
    private lazy var textMessageView: TextMessageView = {
        let view = TextMessageView()
        view.backgroundColor = ButtonColor.main.color
        view.layer.cornerRadius = 10
        view.labelColor = ButtonColor.normal.color
        return view
    }()
    
    private lazy var imageMessageView: ImageMessageView = {
        let view = ImageMessageView()
        return view
    }()
    
    private lazy var scheduleMessageView: ScheduleMessageView = {
        let view = ScheduleMessageView()
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        label.textColor = TextColor.secondary.color
        label.numberOfLines = 1
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
        
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(textMessageView)
        contentStackView.addArrangedSubview(imageMessageView)
        contentStackView.addArrangedSubview(scheduleMessageView)
        
        contentView.addSubview(timeLabel)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        
        contentStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(3)
            make.trailing.equalToSuperview().inset(8)
            make.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.65)
        }
        
        imageMessageView.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width).multipliedBy(0.6)
        }
        
        scheduleMessageView.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width).multipliedBy(0.5)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentStackView.snp.bottom)
            make.trailing.equalTo(contentStackView.snp.leading).offset(-3)
        }
        
    }
    
    func updateChatView(_ message: RealmMessage) {
        
        configureMessageView(message)
        
        timeLabel.text = DateTimeFormatter.shared.convertStringToDateTime(message.dateTime, isCompareCurrentTime: false)
    }
    
    private func configureMessageView(_ message: RealmMessage) {
        resetMessageViewHidden()
        
        switch message.type {
        case MessageType.text:
            textMessageView.isHidden = false
            textMessageView.updateMessageLabel(message)
        case MessageType.image:
            imageMessageView.isHidden = false
            imageMessageView.updateMessageImage(message)
        case MessageType.schedule:
            scheduleMessageView.isHidden = false
            scheduleMessageView.updateMessageSchedule(message)
        default:
            return
        }
    }
    
    private func resetMessageViewHidden() {
        textMessageView.isHidden = true
        imageMessageView.isHidden = true
        scheduleMessageView.isHidden = true
    }
}

