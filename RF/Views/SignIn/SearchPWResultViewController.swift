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
    
    private lazy var PWLabelBottomLine: UIView = createBottomLine()
    private lazy var PWCheckBottomLine: UIView = createBottomLine()
  
    private func createBottomLine() -> UIView {
        let lineView = UIView()
        lineView.backgroundColor = .gray
        return lineView
    }
    
    private lazy var PWLabel: UILabel = {
        let Label = UILabel()
        Label.text = "비밀번호 설정"
        Label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        Label.textColor = TextColor.first.color
        Label.numberOfLines = 1
        return Label
    }()
    
    
    private lazy var pwTextField: PasswordTextField = {
        var field = PasswordTextField()
        field.placeholder = "  비밀번호를 새로 변경해 주세요"
        field.delegate = self
        field.font = .systemFont(ofSize: 14)
        field.setColor(TextColor.first.color)
        field.setButtonColor(TextColor.secondary.color)
        field.borderStyle = UITextField.BorderStyle.none
        field.addSubview(PWLabelBottomLine)
        PWLabelBottomLine.translatesAutoresizingMaskIntoConstraints = false
        configureConstraints(for: field, and: PWLabelBottomLine)
        return field
    }()
    
    private lazy var PWCheckLabel: UILabel = {
        let Label = UILabel()
        Label.text = "비밀번호 확인인"
        Label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        Label.textColor = TextColor.first.color
        Label.numberOfLines = 1
        return Label
    }()
    
    private lazy var pwTextCheckField: PasswordTextField = {
        var field = PasswordTextField()
        field.placeholder = ". 새로운 비밀번호를 다시 입력해주세요."
        field.delegate = self
        field.font = .systemFont(ofSize: 14)
        field.setColor(TextColor.first.color)
        field.setButtonColor(TextColor.secondary.color)
        field.borderStyle = UITextField.BorderStyle.none
        field.addSubview(PWCheckBottomLine)
        PWCheckBottomLine.translatesAutoresizingMaskIntoConstraints = false
        configureConstraints(for: field, and: PWCheckBottomLine)
        return field
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
    
    // bottomLine의 제약 조건을 설정하는 헬퍼 함수
    private func configureConstraints(for textField: UITextField, and bottomLine: UIView) {
        bottomLine.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
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
        
        //비밀번호 설정
        PWLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(29)
        }
        
        //비밀번호를 새로 변경해주세요
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(PWLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(19)
            make.height.equalTo(52)
        }
        
        //비밀번호 확인인
        PWCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(29)
        }
        
        //새로운 비밀번호를 다시 입력해주세요
        pwTextCheckField.snp.makeConstraints { make in
            make.top.equalTo(PWCheckLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(19)
            make.height.equalTo(52)
        }
        
        
        //확인
        nextButton.snp.makeConstraints { make in
            make.leading.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(48)
        }
        
    }
}

