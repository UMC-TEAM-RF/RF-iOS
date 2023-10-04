//
//  SearchPWResultViewController.swift
//  RF
//
//  Created by 나예은 on 2023/10/01.
//

import Foundation
import UIKit
import SnapKit

final class SearchPWResultViewController: UIViewController {
    
    private lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "비밀번호 찾기", style: .done, target: self, action: nil)
        button.isEnabled = false
        button.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: TextColor.first.color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)], for: .disabled)
        return button
    }()
    
    private lazy var PWLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "비밀번호 설정"
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = TextColor.first.color
        nameLabel.numberOfLines = 1
        return nameLabel
    }()
    
    // 변경된 부분: PasswordTextField 사용
    private lazy var PWField: PasswordTextField = {
        let nameField = PasswordTextField()
        nameField.text = "비밀번호를 새로 변경해주세요."
        nameField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameField.textColor = TextColor.first.color
        return nameField
    }()
    
    // 변경된 부분: PasswordTextField의 eyeButton 사용
    private lazy var eyeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "eye_icon"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        // Set the right view for the password field
        PWField.rightView = button
        PWField.rightViewMode = .always
        
        return button
    }()
    
    private lazy var PWCheckLabel: UILabel = {
        let mailLabel = UILabel()
        mailLabel.text = "비밀번호 확인"
        mailLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        mailLabel.textColor = TextColor.first.color
        mailLabel.numberOfLines = 1
        return mailLabel
    }()
    
    private lazy var PWCheckField: UITextField = {
        let mailField = UITextField()
        mailField.text = "새로운 비밀번호를 다시 입력해주세요."
        mailField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        mailField.textColor = TextColor.first.color
        return mailField
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
        
        // searchIDresult UI로 화면 전환
        nextButton.addTarget(self, action: #selector(getter: nextButton), for: .touchUpInside)
        
        // 변경된 부분: togglePasswordVisibility 함수의 target을 self로 지정
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        addSubviews()
    }
    
    // 변경된 부분: togglePasswordVisibility 함수
    @objc private func togglePasswordVisibility() {
        PWField.isSecureTextEntry.toggle()
        let imageName = PWField.isSecureTextEntry ? "eye_icon" : "eye_slash_icon"
        eyeButton.setImage(UIImage(named: imageName), for: .normal)
    }

    //// 나예은_searchIDresult UI로 화면 전환
    @objc func findIdButtonTapped() {
           let searchIDVC = SearchIDResultViewController()
           navigationController?.pushViewController(searchIDVC, animated: true)
       }
    
    private func addSubviews() {
        view.addSubview(PWLabel)
        view.addSubview(PWField)
        view.addSubview(PWCheckLabel)
        view.addSubview(PWCheckField)
        view.addSubview(nextButton)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        // 비밀번호 설정
        PWLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(130)
        }
        
        // 비밀번호를 새로 변경해주세요
        PWField.snp.makeConstraints { make in
            make.top.equalTo(PWLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(19)
        }
        
        // 비밀번호 확인
        PWCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(PWField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(19)
        }
        
        // 새로운 비밀번호를 다시 입력해주세요
        PWCheckField.snp.makeConstraints { make in
            make.top.equalTo(PWCheckLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(19)
        }
        
        // 확인
        nextButton.snp.makeConstraints { make in
            make.leading.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(48)
        }
    }
}

