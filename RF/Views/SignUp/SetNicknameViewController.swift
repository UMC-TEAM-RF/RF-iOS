//
//  SetNicknameViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/03.
//

import UIKit
import SnapKit

class SetNicknameViewController: UIViewController {
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "알프님의\n기본 정보를 설정해주세요!"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 2
        return label
    }()

    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 1
        return label
    }()

    private lazy var nameCheckButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("중복확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.titleLabel?.numberOfLines = 1
        return button
    }()

    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor =  UIColor(hexCode: "#F5F5F5")
        button.layer.cornerRadius = 5
        return button
    }()

    
    private var textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.borderStyle = .none
        field.placeholder = "   닉네임을 입력해주세요"
        field.backgroundColor = UIColor(hexCode: "#F5F5F5")
        field.textColor = UIColor(hexCode: "#818181")
        field.layer.cornerRadius = 5
        return field
    }()
    
    private lazy var warningLbel: UILabel = {
        let label = UILabel()
        label.text = "이후 변경할 수 없으니 정확히 선택해 주세요"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .gray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        view.backgroundColor = .systemBackground
        
        addSubviews()
        configureConstraints()
    }
    
    
    private func addSubviews() {
        view.addSubview(nameCheckButton)
        view.addSubview(topLabel)
        view.addSubview(nicknameLabel)
        view.addSubview(nextButton)
        view.addSubview(textField)
        view.addSubview(warningLbel)
       
    }
    
    private func configureConstraints() {
        
        //알프닝의 기본 정보를 설정해주세요.
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(25)
            make.left.right.equalToSuperview().inset(20)
        }
        
        //닉네임
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.right.equalToSuperview().inset(293)
            make.left.equalToSuperview().inset(20)
        }
        
        //닉네임을 입력해주세요.
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(130)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(122)
            make.bottom.equalToSuperview().inset(570)
        }
        
        //이후 변경할 수 없으니 정확히 선택해 주세요.
        warningLbel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(625)
            make.left.right.equalToSuperview().inset(68)
        }
        
        //중복 확인
        nameCheckButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(110)
            make.left.equalToSuperview().inset(286)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(550)
        }
        
        //다음
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(655)
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
        }

    }
    
    
}
