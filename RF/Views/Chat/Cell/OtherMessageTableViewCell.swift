//
//  OtherMessageTableViewCell.swift
//  iOS_Test
//
//  Created by 이정동 on 2023/07/28.
//

import UIKit

protocol MessageTableViewCellDelegate: AnyObject {
    func longPressedMessageView(_ gesture: UILongPressGestureRecognizer)
    func convertMessage(_ indexPath: IndexPath)
}

class OtherMessageTableViewCell: UITableViewCell {

    static let identifier = "OtherMessageTableViewCell"
    
    private lazy var avatarView: UIImageView = {
        let iv = UIImageView()
        //iv.image = UIImage(named: "LogoImage")
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = contentView.frame.width * 0.1 / 2.0
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var displayNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Unknown"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = TextColor.first.color
        return label
    }()
    
    private lazy var messageView: UIView = {
        let view = UIView()
        view.backgroundColor = ButtonColor.normal.color
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = TextColor.first.color
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping // 글자 단위로 줄바꿈
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var translateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "translate4"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.isHidden = true
        button.tintColor = TextColor.secondary.color
        return button
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        label.textColor = TextColor.secondary.color
        label.numberOfLines = 1
        label.text = "오후 7:15"
        return label
    }()
    
    weak var delegate: MessageTableViewCellDelegate?
    
    var isContinuous: Bool = false {
        didSet {
            self.avatarView.isHidden = isContinuous
            
            let height = isContinuous ? 0 : displayNameLabel.intrinsicContentSize.height
            displayNameLabel.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
        }
    }
    
    
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
        
        contentView.addSubview(messageView)
        contentView.addSubview(timeLabel)
        
        contentView.addSubview(avatarView)
        contentView.addSubview(displayNameLabel)
        
        contentView.addSubview(translateButton)
        
        messageView.addSubview(messageLabel)
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
        
        messageView.snp.makeConstraints { make in
            make.top.equalTo(displayNameLabel.snp.bottom).offset(2)
            make.bottom.equalToSuperview().inset(3)
            make.leading.equalTo(avatarView.snp.trailing).offset(5)
            
        }
        
        messageLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.55)
        }
        
        translateButton.snp.makeConstraints { make in
            make.leading.equalTo(messageView.snp.trailing).offset(5)
            make.bottom.equalTo(messageView.snp.bottom)
            make.size.equalTo(24)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(translateButton.snp.trailing).offset(5)
            make.bottom.equalTo(translateButton.snp.bottom)
        }
        
    }
    
    private func addTargets() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        messageView.addGestureRecognizer(longPress)
        
        translateButton.addTarget(self, action: #selector(translateButtonTapped), for: .touchUpInside)
    }
    
    func updateChatView(_ message: RealmMessage) {
        messageLabel.text = message.content
        timeLabel.text = DateTimeFormatter.shared.convertStringToDateTime(message.dateTime, isCompareCurrentTime: false)
        displayNameLabel.text = message.speaker?.name
        avatarView.load(url: URL(string: "https://rf-aws-bucket.s3.ap-northeast-2.amazonaws.com/userDefault/defaultImage.jpg")!)
        
        if message.langCode != "ko" { translateButton.isHidden = false }
    }
    
    @objc func longPressed(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            print("Long")
            delegate?.longPressedMessageView(gesture)
        }
        
    }
    
    @objc func translateButtonTapped() {
        guard let indexPath = (superview as? UITableView)?.indexPath(for: self) else { return }
        delegate?.convertMessage(indexPath)
    }

}
