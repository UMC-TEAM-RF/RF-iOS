//
//  OtherMessageTableViewCell.swift
//  iOS_Test
//
//  Created by 이정동 on 2023/07/28.
//

import UIKit
import SnapKit

class OtherMessageTableViewCell: UITableViewCell {

    static let identifier = "OtherMessageTableViewCell"
    
    private lazy var avatarView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = contentView.frame.width * 0.1 / 2.0
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var displayNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Unknown"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = TextColor.first.color
        return label
    }()
        
    private lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.distribution = .fill
        view.alignment = .leading
        return view
    }()
    
    private lazy var textMessageView: TextMessageView = {
        let view = TextMessageView()
        view.backgroundColor = ButtonColor.normal.color
        view.layer.cornerRadius = 10
        view.labelColor = TextColor.first.color
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
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .bottom
        view.spacing = 0
        return view
    }()
    
    private lazy var translateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "translate4"), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.isHidden = true
        button.tintColor = TextColor.secondary.color
        return button
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        label.textColor = TextColor.secondary.color
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - [수정 필요할 듯]
    weak var delegate: MessageTableViewCellDelegate? {
        didSet {
            textMessageView.delegate = self.delegate
            imageMessageView.delegate = self.delegate
        }
    }
    
    private var userId: Int?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
        configureConstraints()
        addTargets()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    // MARK: - addSubviews()
    
    private func addSubviews() {
        contentView.addSubview(avatarView)
        contentView.addSubview(displayNameLabel)
        
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(textMessageView)
        contentStackView.addArrangedSubview(imageMessageView)
        contentStackView.addArrangedSubview(scheduleMessageView)
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(translateButton)
        stackView.addArrangedSubview(timeLabel)
        
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        
        avatarView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(3)
            make.leading.equalToSuperview().inset(8)
            make.width.height.equalTo(contentView.snp.width).multipliedBy(0.1)
        }
        
        displayNameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarView.snp.top)
            make.leading.equalTo(avatarView.snp.trailing).offset(5)
            make.height.equalTo(displayNameLabel.intrinsicContentSize.height)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(displayNameLabel.snp.bottom).offset(2)
            make.leading.equalTo(avatarView.snp.trailing).offset(5)
            make.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.6)
            make.bottom.equalToSuperview().inset(3)
        }
        
        imageMessageView.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width).multipliedBy(0.6)
        }
        
        scheduleMessageView.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width).multipliedBy(0.5)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(contentStackView.snp.trailing).offset(5)
            make.bottom.equalTo(contentStackView.snp.bottom)
        }
        
        translateButton.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
    }
    
    private func addTargets() {
        translateButton.addTarget(self, action: #selector(translateButtonTapped), for: .touchUpInside)
        avatarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(avatarViewDidTapped)))
    }
    
    func updateChatView(message: RealmMessage, userLangCode: String, isContinuous: Bool) {
        self.userId = message.speaker?.id
        configureMessageView(message)
        
        // 아바타 사진, 이름 설정
        updateAvatar(message: message, isContinuous: isContinuous)
        
        timeLabel.text = DateTimeFormatter.shared.convertStringToDateTime(message.dateTime, isCompareCurrentTime: false)
        
        // 번역 버튼 보임 여부 설정
        if let langCode = message.langCode, langCode != userLangCode { translateButton.isHidden = false }
        else { translateButton.isHidden = true }
    }
    
    private func updateAvatar(message: RealmMessage, isContinuous: Bool) {
        displayNameLabel.text = message.speaker?.name
        
        if isContinuous {
            avatarView.isHidden = true
            avatarView.image = nil
            displayNameLabel.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
        } else {
            avatarView.isHidden = false
            avatarView.load(url: URL(string: message.speaker?.imgeUrl ?? "")!)
            displayNameLabel.snp.updateConstraints { make in
                make.height.equalTo(displayNameLabel.intrinsicContentSize.height)
            }
        }
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
    
    @objc func translateButtonTapped() {
        guard let indexPath = (superview as? UITableView)?.indexPath(for: self) else { return }
        delegate?.convertMessage(indexPath)
    }
    
    @objc func avatarViewDidTapped() {
        guard let id = self.userId else { return }
        delegate?.didTapAvatarView(id)
    }

}
