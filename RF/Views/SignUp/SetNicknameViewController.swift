//
//  SetNicknameViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/03.
//07

import UIKit
import SnapKit

/// 닉네임 설정하는 화면
final class SetNicknameViewController: UIViewController {
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "닉네임 설정", style: .done, target: self, action: nil)
        btn.isEnabled = false
        btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .disabled)
        return btn
    }()
    
    /// 프로그레스 바
    private lazy var progressBar: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.backgroundColor = UIColor(hexCode: "D1D1D1")
        pv.progress = 0.5
        return pv
    }()
    
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
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.backgroundColor =  UIColor(hexCode: "#F5F5F5")
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
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
        field.font = UIFont.systemFont(ofSize: 14, weight: .regular)
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

        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .systemBackground
        
        addSubviews()
        configureConstraints()
    }
    
    
    private func addSubviews() {
        view.addSubview(progressBar)
        
        view.addSubview(nameCheckButton)
        view.addSubview(topLabel)
        view.addSubview(nicknameLabel)
        view.addSubview(nextButton)
        view.addSubview(textField)
        view.addSubview(warningLbel)
       
    }
    
    private func configureConstraints() {
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        
        //알프닝의 기본 정보를 설정해주세요.
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        //닉네임 
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(25)
            make.trailing.equalToSuperview().inset(295)
            make.leading.equalToSuperview().inset(20)
        }
        
        //닉네임을 입력해주세요.
        textField.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(55)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(125)
            make.height.equalTo(50)
        }
        
        //이후 변경할 수 없으니 정확히 선택해 주세요.
        warningLbel.snp.makeConstraints { make in
            make.top.equalTo(nextButton.snp.top).offset(-30)
            make.leading.trailing.equalToSuperview().inset(70)
        }
        
        //중복 확인
        nameCheckButton.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(65)
            make.leading.equalTo(textField.snp.trailing).offset(30)
            make.trailing.equalToSuperview().inset(25)
        }
        
        //다음
        nextButton.snp.makeConstraints { make in
            make.leading.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(48)
        }

    }
    
    // 다음 버튼 액션
    @objc private func nextButtonTapped() {
        let userInfoSelfViewController = UserInfoSelfViewController()
        navigationItem.backButtonTitle = " "
        navigationController?.pushViewController(userInfoSelfViewController, animated: true)
    }
}
