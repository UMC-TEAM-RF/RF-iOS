//
//  SearchIDResultViewController.swift
//  RF
//
//  Created by 나예은 on 2023/09/25.
//

import Foundation
import UIKit
import SnapKit

final class SearchIDResultViewController: UIViewController {
    
    // MARK: - UI Property
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "아이디 찾기", style: .done, target: self, action: nil)
        button.isEnabled = false
        button.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: TextColor.first.color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)], for: .disabled)
        return button
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = message
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = TextColor.secondary.color
        label.numberOfLines = 1
        return label
    }()
    
    
    private lazy var searchIdLabel: UILabel = {
        let label = UILabel()
        label.text = reultMessage
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = TextColor.first.color
        label.numberOfLines = 1
        return label
    }()
    
    //입니다
    private lazy var stringLabel: UILabel = {
        let label = UILabel()
        label.text = "입니다."
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = TextColor.secondary.color
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.backgroundColor =  BackgroundColor.white.color
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Property
    
    //~님의 아이디는
    var nickName: String = ""
    lazy var message: String = {
        return "\(nickName) 님의 아이디는"
    }()
    
    //진짜 아이디
    var searchIdValue: String = ""
    lazy var reultMessage: String = {
        return "\(searchIdValue)"
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = TextColor.first.color
        view.backgroundColor = .white
        
        addSubviews()
        configureConstraints()
        
        setNickName("알프 19")
        setSearchID("qkrgpwls1")
    }
    
    
    private func addSubviews() {
        view.addSubview(idLabel)
        view.addSubview(stringLabel)
        view.addSubview(searchIdLabel)
        view.addSubview(checkButton)
    }
    
    private func configureConstraints() {
        
        //~님의 아이디는
        idLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalToSuperview().inset(45)
        }
        
        //진짜 아이디
        searchIdLabel.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(45)
        }
        
        
        //~입니다
        stringLabel.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(18)
            make.leading.equalTo(searchIdLabel.snp.trailing).offset(5)
        }
        
        //다음
        checkButton.snp.makeConstraints { make in
            make.leading.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(48)
        }
    }
    
    //~님의 아이디는 에서 아이디 문구 합쳐놓은 것
    func setNickName(_ newNickName: String) {
        nickName = newNickName
        idLabel.text = "\(nickName) 님의 아이디는"
    }
    
    func setSearchID(_ newSearchID: String) {
        searchIdValue = newSearchID
        searchIdLabel.text = "\(searchIdValue)"
    }
}


