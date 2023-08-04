//
//  OtherMessageTableViewCell.swift
//  iOS_Test
//
//  Created by 이정동 on 2023/07/28.
//

import UIKit

protocol MessageTableViewCellDelegate: AnyObject {
    func messagePressed(_ gesture: UILongPressGestureRecognizer)
}

class OtherMessageTableViewCell: UITableViewCell {

    static let identifier = "OtherMessageTableViewCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var avatarView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "LogoImage")
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = contentView.frame.width * 0.1 / 2.0
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var displayNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Unknown"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var messageView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping // 글자 단위로 줄바꿈
        label.isUserInteractionEnabled = true
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
    
    weak var delegate: MessageTableViewCellDelegate?

    var message: String? {
        didSet {
            messageLabel.text = message
        }
    }
    
    var displayName: String? {
        didSet {
            displayNameLabel.text = displayName
        }
    }
    
    var time: Date? {
        didSet {
            
        }
    }
    
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
        
        contentView.addSubview(containerView)
        
        
        containerView.addSubview(messageView)
        containerView.addSubview(timeLabel)
        
        containerView.addSubview(avatarView)
        containerView.addSubview(displayNameLabel)
        
        messageView.addSubview(messageLabel)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
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
            make.verticalEdges.equalToSuperview().inset(5)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.6)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(messageView.snp.bottom)
            make.leading.equalTo(messageView.snp.trailing).offset(3)
        }
        
    }
    
    private func addTargets() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        messageView.addGestureRecognizer(longPress)
    }
    
    @objc func longPressed(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            print("Long")
            delegate?.messagePressed(gesture)
        }
        
    }

}
