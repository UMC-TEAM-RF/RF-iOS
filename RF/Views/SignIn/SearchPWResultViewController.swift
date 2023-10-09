//
//  SearchPWResultViewController.swift
//  RF
//
//  Created by 나예은 on 2023/10/01.
//

import Foundation
import UIKit
import SnapKit

final class SearchPWResultViewController: UIViewController, UITextFieldDelegate {
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "비밀번호 찾기", style: .done, target: self, action: nil)
        btn.isEnabled = false
        btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: TextColor.first.color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)], for: .disabled)
        return btn
    }()
    
    private lazy var PWLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "비밀번호 설정"
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = TextColor.first.color
        nameLabel.numberOfLines = 1
        return nameLabel
    }()
    
    
    private lazy var pwTextField: PasswordTextField = {
        var view = PasswordTextField()
        view.placeholder = "비밀번호를 새로 변경해 주세요"
        view.delegate = self
        view.font = .systemFont(ofSize: 14)
        view.setColor(TextColor.first.color)
        view.setButtonColor(TextColor.secondary.color)
        view.borderStyle = UITextField.BorderStyle.none
        return view
    }()
    
    private lazy var PWCheckLabel: UILabel = {
        let mailLabel = UILabel()
        mailLabel.text = "비밀번호 확인"
        mailLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        mailLabel.textColor = TextColor.first.color
        mailLabel.numberOfLines = 1
        return mailLabel
    }()
    
    private lazy var pwTextCheckField: PasswordTextField = {
        var view = PasswordTextField()
        view.placeholder = "새로운 비밀번호를 다시 입력해주세요."
        view.delegate = self
        view.font = .systemFont(ofSize: 14)
        view.setColor(TextColor.first.color)
        view.setButtonColor(TextColor.secondary.color)
        view.borderStyle = UITextField.BorderStyle.none
        return view
    }()

    @objc private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.backgroundColor =  BackgroundColor.white.color
        button.layer.cornerRadius = 5
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = TextColor.first.color
        view.backgroundColor = .white
    
        
        
        addSubviews()
    }

    
    private func addSubviews() {
        view.addSubview(PWLabel)
        view.addSubview(pwTextField)
        view.addSubview(PWCheckLabel)
        view.addSubview(pwTextCheckField)
        view.addSubview(nextButton)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        PWLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(29)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(PWLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(19)
            make.height.equalTo(52)
        }
        
        //이메일
        PWCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(29)
        }
        
        //인증받기 버튼
        pwTextCheckField.snp.makeConstraints { make in
            make.top.equalTo(PWCheckLabel.snp.bottom).offset(56)
            make.trailing.equalToSuperview().inset(29)
            make.width.equalTo(56)
            make.height.equalTo(32)
        }
        
        
        //다음
        nextButton.snp.makeConstraints { make in
            make.leading.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(48)
        }
        
    }
}

