//
//  UserinfoSelf.swift
//  RF
//
//  Created by 나예은 on 2023/07/19.
//.textColor = UIColor(hexCode: "#3C3A3A") / UIColor(hexCode: "#A0A0A0")
//

import UIKit
import SnapKit

class UserinfoSelf: UIViewController {
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "한 줄 소개"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(hexCode: "#3C3A3A")
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = "  " + "나를 나타낼 수 있는 대표적 키워드를 적어주세요."
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(hexCode: "#3C3A3A")
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.borderStyle = .none
        field.layer.cornerRadius = 5
        field.placeholder = "   " + "한 줄 소개를 작성해주세요!"
        field.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        field.backgroundColor = .clear
        field.textColor = UIColor(hexCode: "#A0A0A0")
        let bottomLine = UIView()
        bottomLine.backgroundColor = .gray
        field.addSubview(bottomLine)
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.leadingAnchor.constraint(equalTo: field.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: field.trailingAnchor).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: field.bottomAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return field
        }()

    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "이후에 변경할 수 없으니 신중히 결정해주세요!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(hexCode: "#A0A0A0")
        label.numberOfLines = 1
        return label
    }()

    // 이미지 왼쪽 화살표
    private lazy var imageView: UIImageView = {
            let imageView = UIImageView(frame: CGRect(x: 50, y: 100, width: 200, height: 200))
            imageView.contentMode = .scaleAspectFit
            if let image = UIImage(named: "leftArrow") {
                imageView.image = image
            }
            return imageView
        }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(UIColor(hexCode: "#3C3A3A") , for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
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
        view.addSubview(imageView) // 왼쪽 화살표 이미지
        view.addSubview(topLabel) // 한 줄 소개
        view.addSubview(subLabel) // 나를 나타낼 수 있는 대표적 키워드를 적어주세요
        view.addSubview(textField) // 한 줄 소개를 작성해주세요!
        view.addSubview(warningLabel) // 이후에 변경할 수 없으니 신중히 결정해주세요!
        view.addSubview(nextButton) // 다음
    }
    
    private func configureConstraints() {
        
        // 왼쪽 화살표 이미지
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(17)
            make.leading.equalToSuperview().inset(10)
        }
        
        //한 줄 소개
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalToSuperview().inset(44)
        }
        
        // 나를 나타낼 수 있는 대표적 키워드를 적어주세요
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // 한 줄 소개를 작성해주세요!
        textField.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(55)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        // 이후에 변경할 수 없으니 신중히 결정해주세요!
        warningLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-20)
            make.leading.trailing.equalToSuperview().inset(70)
        }
    
        //다음
        nextButton.snp.makeConstraints { make in
            make.leading.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(48)
        }
        
    }
}


