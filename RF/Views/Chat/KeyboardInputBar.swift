//
//  KeyboardInputBar.swift
//  RF
//
//  Created by 이정동 on 2023/08/04.
//

import UIKit
import SnapKit

protocol KeyboardInputBarDelegate: AnyObject {
    func didTapSend(_ text: String, isTranslated: Bool)
    func didTapTranslate(_ isTranslated: Bool)
    func didTapPlus()
}

class KeyboardInputBar: UIView {
    
    private lazy var divLine: UIView = {
        let view = UIView()
        view.backgroundColor = BackgroundColor.dark.color
        return view
    }()
    
    private lazy var inputField: UITextView = {
        let tv = UITextView()
        tv.textColor = TextColor.first.color
        tv.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        tv.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        tv.backgroundColor = ButtonColor.normal.color
        tv.layer.borderWidth = 1
        tv.layer.borderColor = TextColor.secondary.color.cgColor
        tv.layer.cornerRadius = 10
        tv.delegate = self
        return tv
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = TextColor.secondary.color
        return button
    }()
    
    private lazy var translateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left.arrow.right"), for: .normal)
        button.tintColor = TextColor.secondary.color
        return button
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = TextColor.secondary.color
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.isEnabled = false
        return button
    }()
    
    weak var delegate: KeyboardInputBarDelegate?
    
    var isTranslated: Bool = false {
        didSet {
            self.translateButton.tintColor = isTranslated ? ButtonColor.main.color : TextColor.secondary.color
            let image = isTranslated ? UIImage(systemName: "checkmark") : UIImage(systemName: "paperplane")
            self.sendButton.setImage(image, for: .normal)
        }
    }
    
    var keyboardInputView: UIView? {
        didSet {
            inputField.inputView = keyboardInputView
            inputField.reloadInputViews()
        }
    }
    
    var inputFieldText: String? {
        didSet {
            inputField.text = inputFieldText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureConstraints()
        addTargets()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(textViewTapped))
        inputField.addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        addSubview(inputField)
        addSubview(plusButton)
        addSubview(translateButton)
        addSubview(sendButton)
        addSubview(divLine)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        plusButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(15)
            make.width.height.equalTo(30)
        }
        
        sendButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(15)
            make.width.height.equalTo(30)
        }
        
        translateButton.snp.makeConstraints { make in
            make.trailing.equalTo(sendButton.snp.leading).offset(-5)
            make.bottom.equalToSuperview().inset(10)
            make.width.height.equalTo(30)
        }
        
        inputField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalTo(plusButton.snp.trailing).offset(10)
            make.trailing.equalTo(translateButton.snp.leading).offset(-10)
            make.height.equalTo(30)
        }
        
        divLine.snp.makeConstraints { make in
            make.bottom.equalTo(inputField.snp.top).offset(-10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func addTargets() {
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        translateButton.addTarget(self, action: #selector(translateButtonTapped), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
    }
    
    // 전송 버튼 활성화 여부 결정
    private func isSendButtonActivate(_ bool: Bool) {
        if bool {
            sendButton.isEnabled = true
            sendButton.backgroundColor = ButtonColor.main.color
            sendButton.tintColor = ButtonColor.normal.color
        } else {
            sendButton.isEnabled = false
            sendButton.backgroundColor = .white
            sendButton.tintColor = TextColor.secondary.color
        }
    }
    
    // 메시지 입력 필드 더보기 버튼
    // (KeyboardInputBar View에서 변경할 수 있도록 수정하기 => Delegate 사용 X)
    @objc func plusButtonTapped() {
        inputField.tintColor = .clear
        inputField.becomeFirstResponder()
        delegate?.didTapPlus()
    }
    
    // 메시지 입력 필드 번역 버튼
    @objc func translateButtonTapped() {
        isTranslated.toggle()
        delegate?.didTapTranslate(isTranslated)
    }
    
    // 메시지 입력 필드 전송 버튼
    @objc func sendButtonTapped() {
        delegate?.didTapSend(inputField.text, isTranslated: isTranslated)
        if !isTranslated { // 메시지 전송인 경우
            inputField.text.removeAll()
            isSendButtonActivate(false)
        }
        isTranslated = false
    }
    
    // TextView.inputView를 키보드로 변경
    @objc func textViewTapped() {
        inputField.tintColor = ButtonColor.main.color
        inputField.inputView = nil
        inputField.reloadInputViews()
        inputField.becomeFirstResponder()
    }
}

extension KeyboardInputBar: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let textCount = textView.text.trimmingCharacters(in: .whitespacesAndNewlines).count
        if textCount == 0 {
            isSendButtonActivate(false)
        } else {
            isSendButtonActivate(true)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(#function)
    }

}
