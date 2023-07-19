//
//  UserinfoSelf.swift
//  RF
//
//  Created by 나예은 on 2023/07/19.
//

import UIKit
import SnapKit

class UserinfoSelf: UIViewController {
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "본인 한 줄 소개를 해주세요."
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 2
        return label
    }()

    private lazy var keywordLabel: UILabel = {
        let label = UILabel()
        label.text = "나를 나타낼 수 있는 대표적 키워드를 적어주세요."
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 1
        return label
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
        field.placeholder = "   한 줄 소개를 작성해주세요!"
        field.backgroundColor = UIColor(hexCode: "#F5F5F5")
        field.textColor = UIColor(hexCode: "#818181")
        field.layer.cornerRadius = 5
        return field
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        view.backgroundColor = .systemBackground
        
        addSubviews()
        configureConstraints()
    }
    
    
    private func addSubviews() {
        view.addSubview(topLabel)
        view.addSubview(keywordLabel)
        view.addSubview(nextButton)
        view.addSubview(textField)
       
    }
    
    private func configureConstraints() {
        
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        keywordLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(25)
            make.trailing.equalToSuperview().inset(-20)
            make.leading.equalToSuperview().inset(20)
        }
        

        textField.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(55)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        //다음
        nextButton.snp.makeConstraints { make in
            make.leading.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(48)
        }

    }
    
    
}

