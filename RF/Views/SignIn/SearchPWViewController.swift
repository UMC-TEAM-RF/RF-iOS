//
//  SearchIDViewController.swift
//  RF
//
//  Created by 나예은 on 2023/09/19.
//

import Foundation
import UIKit
import SnapKit

final class SearchPWViewController: UIViewController {
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "비밀번호 찾기", style: .done, target: self, action: nil)
        btn.isEnabled = false
        btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: TextColor.first.color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)], for: .disabled)
        return btn
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.textColor = TextColor.first.color
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var idTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.borderStyle = .none
        field.layer.cornerRadius = 5
        field.placeholder = "  " + "아이디를 입력해주세요."
        field.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        field.backgroundColor = .clear
        field.textColor = TextColor.first.color
        return field
    }()
    
    private lazy var idBottomLine: UIView = createBottomLine()
    
    private lazy var mailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.textColor = TextColor.first.color
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var mailField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.borderStyle = .none
        field.layer.cornerRadius = 5
        field.placeholder = "  " + "이메일을 입력해주세요."
        field.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        field.backgroundColor = .clear
        field.textColor = TextColor.first.color
        return field
    }()
    
    private lazy var mailBottomLine: UIView = createBottomLine()
    
    private lazy var emailCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증받기", for: .normal)
        button.setTitleColor(TextColor.secondary.color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.titleLabel?.numberOfLines = 1
        button.backgroundColor =  BackgroundColor.white.color
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var checkNumLabel: UILabel = {
        let label = UILabel()
        label.text = "인증번호"
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.textColor = TextColor.first.color
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var checkNumField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.borderStyle = .none
        field.layer.cornerRadius = 5
        field.placeholder = "  " + "인증번호를 입력해주세요."
        field.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        field.backgroundColor = .clear
        field.textColor = TextColor.first.color
        return field
    }()
    
    private lazy var checkNumBottomLine: UIView = createBottomLine()
    
    private lazy var nextButton: UIButton = {
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
        navigationController?.navigationBar.tintColor = .black
        addSubviews()
        addTargets()
        
    }
    
    private func addSubviews() {
        view.addSubview(idTextField)
        view.addSubview(idLabel)
        view.addSubview(idBottomLine)
        
        
        view.addSubview(mailField)
        view.addSubview(mailLabel)
        view.addSubview(mailBottomLine)
        
        
        view.addSubview(checkNumLabel)
        view.addSubview(checkNumField)
        view.addSubview(checkNumBottomLine)
        
        view.addSubview(emailCheckButton)
        view.addSubview(nextButton)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        idLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(29)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(19)
            make.height.equalTo(52)
        }
        
        idBottomLine.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom)
            make.horizontalEdges.equalTo(idTextField.snp.horizontalEdges)
            make.height.equalTo(1)
        }
        
        //이메일
        mailLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(29)
        }
        
        //인증받기 버튼
        emailCheckButton.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(56)
            make.trailing.equalToSuperview().inset(29)
            make.width.equalTo(56)
            make.height.equalTo(32)
        }
        
        //이메일을 입력해주세요
        mailField.snp.makeConstraints { make in
            make.top.equalTo(mailLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(19)
            make.height.equalTo(48)
        }
        
        mailBottomLine.snp.makeConstraints { make in
            make.top.equalTo(mailField.snp.bottom)
            make.horizontalEdges.equalTo(mailField.snp.horizontalEdges)
            make.height.equalTo(1)
        }
        
        //인증번호
        checkNumLabel.snp.makeConstraints { make in
            make.top.equalTo(mailField.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(29)
        }
        
        
        //인증번호를 입력해주세요
        checkNumField.snp.makeConstraints { make in
            make.top.equalTo(checkNumLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(19)
            make.height.equalTo(48)
        }
        
        checkNumBottomLine.snp.makeConstraints { make in
            make.top.equalTo(checkNumField.snp.bottom)
            make.horizontalEdges.equalTo(checkNumField.snp.horizontalEdges)
            make.height.equalTo(1)
        }
        
        //다음
        nextButton.snp.makeConstraints { make in
            make.leading.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(48)
        }
        
    }
    
    private func addTargets() {
        nextButton.addTarget(self, action: #selector(findPwButtonTapped), for: .touchUpInside)
    }
    
    private func createBottomLine() -> UIView {
        let lineView = UIView()
        lineView.backgroundColor = .gray
        return lineView
    }
    
    // MARK: - @objc func
    
    @objc func findPwButtonTapped() {
        let vc = SearchPWResultViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
