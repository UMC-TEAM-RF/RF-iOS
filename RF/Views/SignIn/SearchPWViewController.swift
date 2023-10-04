//
//  SearchPWViewController.swift
//  RF
//
//  Created by 나예은 on 2023/09/26.
//

import Foundation
import UIKit
import SnapKit

final class SearchPWViewController: UIViewController {
    
    private lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "비밀번호 찾기", style: .done, target: self, action: nil)
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
        
        //searchIDresult UI로 화면 전환
        nextButton.addTarget(self, action: #selector(resetPasswordButton), for: .touchUpInside)
        //
        
        addSubviews()
    }
    
    ////나예은_searchPWresult UI로 화면 전환
    @objc func resetPasswordButton() {
           let searchPWResultVC = SearchPWResultViewController()
           navigationController?.pushViewController(searchPWResultVC, animated: true)
       }
    //
    
    private func addSubviews() {
        view.addSubview(nameField)//
        view.addSubview(nameLabel)//
        view.addSubview(mailField)
        view.addSubview(mailLabel)
        view.addSubview(checknumLabel)
        view.addSubview(checkNumField)
        view.addSubview(checkBtn)
        view.addSubview(nextButton)
        
         configureConstraints()
    }
    
    private func configureConstraints() {
        
        //이름
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(130)
            make.bottom.equalTo(nameField.snp.top).offset(-4)
        }
        
        //이름을 입력해주세요
        nameField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(19)
        }
        
        //이메일
        mailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(19)
        }
        
        //이메일을 입력해주세요
        mailField.snp.makeConstraints { make in
            make.top.equalTo(mailLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(19)
        }
        
        //인증번호
        checknumLabel.snp.makeConstraints { make in
            make.top.equalTo(mailField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(19)
        }
        
        //인증번호를 입력해주세요
        checkNumField.snp.makeConstraints { make in
            make.top.equalTo(checknumLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(19)
        }
        
        //다음
        nextButton.snp.makeConstraints { make in
            make.leading.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(48)
        }
        
    }
    
    
    
    
    
}
