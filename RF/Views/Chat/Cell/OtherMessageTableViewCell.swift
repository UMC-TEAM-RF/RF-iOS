//
//  OtherMessageTableViewCell.swift
//  iOS_Test
//
//  Created by 이정동 on 2023/07/28.
//

import UIKit

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
    
    private lazy var textMessageView: TextMessageView = {
        let view = TextMessageView()
        return view
    }()
    
    // MARK: - [수정 필요할 듯]
    weak var delegate: MessageTableViewCellDelegate? {
        didSet {
            textMessageView.delegate = self.delegate
        }
    }
    
    // MARK: - [수정 필요] 함수로 분리하기
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
        contentView.addSubview(avatarView)
        contentView.addSubview(displayNameLabel)
        contentView.addSubview(messageView)
        messageView.addSubview(textMessageView)
        
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
        
        messageView.snp.makeConstraints { make in
            make.top.equalTo(displayNameLabel.snp.bottom).offset(2)
            make.leading.equalTo(avatarView.snp.trailing).offset(5)
            make.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.55)
            make.bottom.equalToSuperview().inset(3)
        }
    
        textMessageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.leading.equalTo(messageView.snp.trailing).offset(5)
            make.bottom.equalTo(messageView.snp.bottom)
        }
        
        translateButton.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
    }
    
    private func addTargets() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        messageView.addGestureRecognizer(longPress)
        
        translateButton.addTarget(self, action: #selector(translateButtonTapped), for: .touchUpInside)
    }
    
    func updateChatView(message: RealmMessage, userLangCode: String, indexPath: IndexPath) {
        // TextMessageView 업데이트
        textMessageView.updateMessageLabel(message)
        
        // MARK: - [수정 필요] ImageMessageView, ScheduleMessageView 업데이트 필요
        
        timeLabel.text = DateTimeFormatter.shared.convertStringToDateTime(message.dateTime, isCompareCurrentTime: false)
        displayNameLabel.text = message.speaker?.name
        avatarView.load(url: URL(string: "https://rf-aws-bucket.s3.ap-northeast-2.amazonaws.com/userDefault/defaultImage.jpg")!)
        
        if let langCode = message.langCode, langCode != userLangCode { translateButton.isHidden = false }
        else { translateButton.isHidden = true }
        
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
