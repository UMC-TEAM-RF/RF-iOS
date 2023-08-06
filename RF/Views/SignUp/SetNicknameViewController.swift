//
//  SetNicknameViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/03.
//07

import UIKit
import SnapKit
import RxSwift
import RxCocoa

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
    
    private let disposeBag = DisposeBag()
    private let viewModel = SetNicknameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .systemBackground
        
        addSubviews()
        addTargets()
    }
    
    
    private func addSubviews() {
        view.addSubview(progressBar)
        
        view.addSubview(nameCheckButton)
        view.addSubview(topLabel)
        view.addSubview(nicknameLabel)
        view.addSubview(nextButton)
        view.addSubview(textField)
        view.addSubview(warningLbel)
       
        configureConstraints()
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
    
    /// MARK:  Add Target (button, textFields, ...)
    private func addTargets(){
        nextButton.rx.tap
            .bind { [weak self] in
                self?.moveToNextPage()
            }
            .disposed(by: disposeBag)
        
        nameCheckButton.rx.tap
            .bind{ [weak self] in
                self?.viewModel.checkNickName()
                    .subscribe(onNext: { check in // 닉네임 중복인 경우
                        self?.showOverlapAlert(text: "닉네임 중복입니다!")
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
            }
            .disposed(by: disposeBag)
        
        textField.rx.text
            .bind { [weak self] nickName in
                if let nickName = nickName {
                    self?.viewModel.checknickNameRelay.accept(false)
                    self?.viewModel.nickNameRelay.accept(nickName)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    /// MARK: 다음 화면으로 넘어가는 함수
    private func moveToNextPage(){
        viewModel.checkFinalNickName()
            .subscribe(onNext: { [weak self] check in
                if check {
                    let userInfoSelfViewController = UserInfoSelfViewController()
                    self?.navigationItem.backButtonTitle = " "
                    self?.navigationController?.pushViewController(userInfoSelfViewController, animated: true)
                    SignUpDataViewModel.viewModel.nickNameRelay.accept(self?.viewModel.nickNameRelay.value ?? "")
                }
                else{
                    self?.showOverlapAlert(text: "중복 확인을 해주세요!")
                }
            })
            .disposed(by: disposeBag)
        
    }
 
    /// MARK: 중복된 아이디인 경우 팝행창 알림 실행
    private func showOverlapAlert(text: String){
        let sheet = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default)
        
        sheet.addAction(success)
        self.present(sheet,animated: true)
    }
    
}
