//
//  SearchIDViewController.swift
//  RF
//
//  Created by 나예은 on 2023/09/19.
//

import Foundation
import UIKit
import SnapKit

final class SearchIDViewController: UIViewController {
    
    private lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "아이디 찾기", style: .done, target: self, action: nil)
        button.isEnabled = false
        button.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: TextColor.first.color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)], for: .disabled)
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "이름"
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = TextColor.first.color
        nameLabel.numberOfLines = 1
        return nameLabel
    }()
    
    private lazy var nameField: UITextField = {
        let nameField = UITextField()
        nameField.text = "이름을 입력해주세요."
        nameField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameField.textColor = TextColor.first.color
        return nameField
    }()
    
    private lazy var mailLabel: UILabel = {
        let mailLabel = UILabel()
        mailLabel.text = "이메일"
        mailLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        mailLabel.textColor = TextColor.first.color
        mailLabel.numberOfLines = 1
        return mailLabel
    }()
    
    private lazy var mailField: UITextField = {
        let mailField = UITextField()
        mailField.text = "이메일을 입력해주세요."
        mailField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        mailField.textColor = TextColor.first.color
        return mailField
    }()
    
    private lazy var checkBtn: UIButton = {
        let checkBtn = UIButton()
        return checkBtn
    }()
    
    private lazy var checknumLabel: UILabel = {
        let checknum = UILabel()
        checknum.text = "인증번호"
        checknum.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        checknum.textColor = TextColor.first.color
        checknum.numberOfLines = 1
        return checknum
    }()
    
    private lazy var checkNumField: UITextField = {
        let checkNumField = UITextField()
        checkNumField.text = "인증 번호를 입력해주세요."
        checkNumField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        checkNumField.textColor = TextColor.first.color
        return checkNumField
    }()
    
    private lazy var nextBtn: UIButton = {
        let nextBtn = UIButton()
        return nextBtn
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
        view.addSubview(nameField)
        view.addSubview(nameLabel)
        view.addSubview(mailField)
        view.addSubview(mailLabel)
        view.addSubview(checknumLabel)
        view.addSubview(checkNumField)
        view.addSubview(checkBtn)
        view.addSubview(nextBtn)
       
       // configureConstraints()
    }
    /*
    private func configureConstraints() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(leftButton.snp.bottom).offset(30)
            
        }
        
        //닉네임
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(25)
            make.trailing.equalToSuperview().inset(295)
            make.leading.equalToSuperview().inset(20)
        }
       
*/
    }

    
   


