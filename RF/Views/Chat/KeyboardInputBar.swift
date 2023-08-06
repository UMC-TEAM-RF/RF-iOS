//
//  KeyboardInputBar.swift
//  RF
//
//  Created by 이정동 on 2023/08/04.
//

import UIKit
import SnapKit

protocol KeyboardInputBarDelegate: AnyObject {
    func didTapSend(_ text: String)
    func didTapTranslate(_ isTranslated: Bool)
    func didTapPlus()
}

class KeyboardInputBar: UIView {
    
    private lazy var divLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private lazy var inputField: UITextView = {
        let tv = UITextView()
        tv.textColor = .black
        tv.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        tv.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        tv.backgroundColor = .systemGray5
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.layer.cornerRadius = 10
        tv.delegate = self
        return tv
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    private lazy var translateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left.arrow.right"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = .lightGray
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.isEnabled = false
        return button
    }()
    
    weak var delegate: KeyboardInputBarDelegate?
    
    var isTranslated: Bool = false {
        didSet {
            self.translateButton.tintColor = isTranslated ? .tintColor : .lightGray
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
    
    private func isSendButtonActivate(_ bool: Bool) {
        if bool {
            sendButton.isEnabled = true
            sendButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            sendButton.tintColor = .white
        } else {
            sendButton.isEnabled = false
            sendButton.backgroundColor = .white
            sendButton.tintColor = .lightGray
        }
    }
    
    @objc func plusButtonTapped() {
        inputField.tintColor = .clear
        delegate?.didTapPlus()
    }
    
    @objc func translateButtonTapped() {
        isTranslated.toggle()
        delegate?.didTapTranslate(isTranslated)
    }
    
    @objc func sendButtonTapped() {
        if isTranslated {
            inputField.text = "Translate!!"
        } else {
            delegate?.didTapSend(inputField.text)
            inputField.text.removeAll()
            isSendButtonActivate(false)
        }
    }
    
    @objc func textViewTapped() {
        inputField.tintColor = .tintColor
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
