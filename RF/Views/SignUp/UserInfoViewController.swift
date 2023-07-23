//
//  UserInfoViewController.swift
//  RF
//
//  Created by 나예은 on 2023/07/10.
//07-1

import UIKit
import SnapKit
import SwiftUI

class UserInfoViewController: UIViewController {
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "알프님의\n기본 정보를 설정해주세요!"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    
    private lazy var userNationLabel: UILabel = {
        let label = UILabel()
        label.text = "출생 국가"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    private lazy var nationButton: UIButton = {
        let button = UIButton()
        button.setTitle("  국가를 선택해주세요", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor =  UIColor(hexCode: "#F5F5F5")
        button.layer.cornerRadius = 5
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private lazy var favNationLabel: UILabel = {
        let label = UILabel()
        label.text = "관심 나라"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    private lazy var favNationButton: UIButton = {
        let button = UIButton()
        button.setTitle("  관심있는 나라를 선택해주세요", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor =  UIColor(hexCode: "#F5F5F5")
        button.layer.cornerRadius = 5
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private lazy var favLanguageLabel: UILabel = {
        let label = UILabel()
        label.text = "관심 언어"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    private lazy var favLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle("  관심있는 언어를 선택해주세요", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor =  UIColor(hexCode: "#F5F5F5")
        button.layer.cornerRadius = 5
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        
        let UserinfoSelf = UserinfoSelf()
        navigationController?.pushViewController(UserinfoSelf, animated: true)//07-2
        
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.backgroundColor =  UIColor(hexCode: "#F5F5F5")
        button.layer.cornerRadius = 5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        configureConstraints()
        
    }
    
    private func addSubviews() {
        view.addSubview(topLabel)
        view.addSubview(userNationLabel)
        view.addSubview(favNationLabel)
        view.addSubview(favLanguageLabel)
        view.addSubview(nextButton)
        view.addSubview(nationButton)
        view.addSubview(favNationButton)
        view.addSubview(favLanguageButton)
    }
    
    private func configureConstraints() {
        
        //알프닝의 기본 정보를 설정해주세요.
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        //출생 국가
        userNationLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        //국가 설정 메뉴 버튼
        nationButton.snp.makeConstraints { make in
            make.top.equalTo(userNationLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(47)
        }
        
        //관심 나라
        favNationLabel.snp.makeConstraints { make in
            make.top.equalTo(nationButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        //관심 나라 설정 메뉴 버튼
        favNationButton.snp.makeConstraints { make in
            make.top.equalTo(favNationLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(47)
        }
        
        //관심 언어
        favLanguageLabel.snp.makeConstraints { make in
            make.top.equalTo(favNationButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        //관심 언어 설정 메뉴 버튼
        favLanguageButton.snp.makeConstraints { make in
            make.top.equalTo(favLanguageLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(47)
        }
        
        //다음
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(655)
            make.leading.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
        }
        
    }
}
