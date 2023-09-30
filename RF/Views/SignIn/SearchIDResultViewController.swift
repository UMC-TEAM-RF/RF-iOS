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
    
    private lazy var IDlabel: UILabel = {
        let label = UILabel()
        label.text = message
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = TextColor.secondary.color
        label.numberOfLines = 1
        return label
    }()
    
    
    private lazy var SearchIDlabel: UILabel = {
        let label = UILabel()
        label.text = reultmessage
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = TextColor.first.color
        label.numberOfLines = 1
        return label
    }()
    
    //입니다
    private lazy var stringlabel: UILabel = {
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
    var SearchID: String = ""
    lazy var reultmessage: String = {
        return "\(SearchID)"
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
        view.addSubview(IDlabel)
        view.addSubview(stringlabel)
        view.addSubview(SearchIDlabel)
        view.addSubview(checkButton)
    }
    
    private func configureConstraints() {
        
        //~님의 아이디는
        IDlabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalToSuperview().inset(45)
        }

        //진짜 아이디
        SearchIDlabel.snp.makeConstraints { make in
            make.top.equalTo(IDlabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(45)
        }
        
        
        //~입니다
        stringlabel.snp.makeConstraints { make in
            make.top.equalTo(IDlabel.snp.bottom).offset(18)
            make.leading.equalTo(SearchIDlabel.snp.trailing).offset(5)
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
        IDlabel.text = "\(nickName) 님의 아이디는"
    }
    
    func setSearchID(_ newSearchID: String) {
            SearchID = newSearchID
            SearchIDlabel.text = "\(SearchID)"
        }
}


