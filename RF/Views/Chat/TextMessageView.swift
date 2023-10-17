//
//  TextMessageView.swift
//  RF
//
//  Created by 이정동 on 10/17/23.
//

import UIKit
import SnapKit

class TextMessageView: UIView {
    
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
    
    weak var delegate: MessageTableViewCellDelegate?
    
    var indexPath: IndexPath?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        addSubview(messageView)
        messageView.addSubview(messageLabel)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        
        messageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(10)
//            make.width.lessThanOrEqualTo(self.snp.width).multipliedBy(0.55)
            make.width.lessThanOrEqualTo(self.snp.width)
        }
    }
    
    private func addTargets() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        messageView.addGestureRecognizer(longPress)
        
    }
    
    func updateMessageLabel(_ message: RealmMessage) {
        if message.isTranslated { messageLabel.text = message.translatedContent }
        else { messageLabel.text = message.content }
    }
    
    @objc func longPressed(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            print("Long")
            delegate?.longPressedMessageView(gesture)
        }
        
    }
}
