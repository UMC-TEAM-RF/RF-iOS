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

    private lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "아이디 찾기", style: .done, target: self, action: nil)
        button.isEnabled = false
        button.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: TextColor.first.color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)], for: .disabled)
        return button
    }()
    
    //~님의 아이디는
    var nickName: String = ""
    lazy var message: String = {
        return "\(nickName) 님의 아이디는"
    }()
    private lazy var IDlabel: UILabel = {
        let label = UILabel()
        label.text = message
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = TextColor.first.color
        label.numberOfLines = 1
        return label
    }()
    
    //진짜 아이디
    var SearchID: String = ""
    lazy var reultmessage: String = {
        return "\(SearchID)"
    }()
    private lazy var SearchIDlabel: UILabel = {
        let SearchIDlabel = UILabel()
        SearchIDlabel.text = reultmessage
        SearchIDlabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        SearchIDlabel.textColor = TextColor.first.color
        SearchIDlabel.numberOfLines = 1
        return SearchIDlabel
    }()
    
    //입니다
    private lazy var stringlabel: UILabel = {
        let label = UILabel()
        label.text = "입니다."
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = TextColor.first.color
        label.numberOfLines = 1
        return label
    }()
    
    //확인버튼
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.backgroundColor = BackgroundColor.white.color
        button.layer.cornerRadius = 5
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = TextColor.first.color
        view.backgroundColor = .white
        
        addSubviews()
        configureConstraints()
    }
    
    //~님의 아이디는 에서 아이디 문구 합쳐놓은 것
    func setNickName(_ newNickName: String) {
        nickName = newNickName
        IDlabel.text = "\(nickName) 님의 아이디는"
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(130)
            make.leading.trailing.equalToSuperview().inset(45)
        }

        //진짜 아이디
        SearchIDlabel.snp.makeConstraints { make in
            make.top.equalTo(IDlabel.snp.bottom).offset(12)
            make.trailing.equalToSuperview().inset(45)
        }
        
        
        //~입니다
        stringlabel.snp.makeConstraints { make in
            make.top.equalTo(IDlabel.snp.bottom).offset(12)
            make.leading.equalTo(SearchIDlabel.snp.leading).offset(0)
        }
        
        //확인버튼
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(IDlabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }
}

