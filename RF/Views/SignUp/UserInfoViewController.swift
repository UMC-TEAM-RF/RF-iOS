//
//  UserInfoViewController.swift
//  RF
//
//  Created by 나예은 on 2023/07/10.
//

import UIKit
import SnapKit

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
    
    //

    
    
    private lazy var favNationLabel: UILabel = {
        let label = UILabel()
        label.text = "관심 나라"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        return label
    }()

    private lazy var favLanguageLabel: UILabel = {
        let label = UILabel()
        label.text = "관심 언어"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        
        let Userinfoselfnext = UserinfoSelf()
        navigationController?.pushViewController(UserinfoSelf(), animated: true)
        
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
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
    }
    
    private func configureConstraints() {
        
        //알프닝의 기본 정보를 설정해주세요.
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        //출생 국가
        userNationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(110)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        //관심 나라
        favNationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(198)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        //관심 언어
        favLanguageLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(286)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        //다음
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(655)
            make.leading.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}

