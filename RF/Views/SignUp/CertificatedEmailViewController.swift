//
//  CertificatedEmailViewController.swift
//  RF
//
//  Created by 정호진 on 2023/08/06.
//

import Foundation
import SnapKit
import RxSwift
import UIKit

/// 이메일 인증하는 화면
final class CertificatedEmailViewController: UIViewController {
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "학교 이메일로 인증하기", style: .done, target: self, action: nil)
        btn.isEnabled = false
        btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: TextColor.first.color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)], for: .disabled)
        return btn
    }()
    
    /// MARK: 프로그레스 바
    private lazy var progressBar: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.backgroundColor = UIColor(hexCode: "D1D1D1")
        pv.progress = 0.5
        return pv
    }()
    
    /// MARK: '이메일을 입력해주세요' 제목
    private lazy var inputEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일을 입력해주세요"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 이메일 입력하는 textField
    private lazy var emailTextField: EmailCustomTextField = {
        let field = EmailCustomTextField()
        field.backgroundColor = .clear
        field.placeholder = "이메일을 입력해주세요"
        return field
    }()
    
    /// MARK: 인증 버튼
    private lazy var certificatedEmailButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("인증하기", for: .normal)
        btn.backgroundColor = ButtonColor.normal.color
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.setTitleColor(TextColor.secondary.color, for: .normal)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    /// MARK: '전송된 코드를 입력해주세요' 제목
    private lazy var inputCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "전송된 코드를 입력해주세요"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 인증 코드 입력하는 textField
    private lazy var codeTextField: EmailCustomTextField = {
        let field = EmailCustomTextField()
        field.backgroundColor = .clear
        field.placeholder = "코드를 입력해주세요"
        field.tag = 98
        return field
    }()
    
    /// MARK: 인증 버튼
    private lazy var certificatedCodeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("인증하기", for: .normal)
        btn.backgroundColor = ButtonColor.normal.color
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.setTitleColor(TextColor.secondary.color, for: .normal)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    /// MARK: Next Button
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.backgroundColor =  ButtonColor.normal.color
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = CertificatedEmailViewModel()
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = TextColor.first.color
        view.backgroundColor = .white
        
        addSubViews()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        codeTextField.resignFirstResponder()
    }
    
    
    /// MARK: Add UI
    private func addSubViews() {
        view.addSubview(progressBar)
        view.addSubview(inputEmailLabel)
        view.addSubview(emailTextField)
        view.addSubview(certificatedEmailButton)
        view.addSubview(nextButton)
        
        configureConstraints()
    }
    
    /// MARK: Setting AutoLayout
    private func configureConstraints() {
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        inputEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(inputEmailLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/20)
        }
        
        certificatedEmailButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.top)
            make.trailing.equalTo(emailTextField.snp.trailing)
            make.height.equalTo(emailTextField.snp.height).multipliedBy(0.8)
            make.width.equalTo(emailTextField.snp.width).multipliedBy(0.2)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/18)
        }
    }
    
    /// MARK: Add code view
    private func addCodeView(){
        view.addSubview(inputCodeLabel)
        view.addSubview(codeTextField)
        view.addSubview(certificatedCodeButton)
        
        setCodeViewAutoLayout()
    }
    
    /// MARK: set code view AutoLayout
    private func setCodeViewAutoLayout(){
        inputCodeLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(inputCodeLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/20)
        }
        
        certificatedCodeButton.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.top)
            make.trailing.equalTo(codeTextField.snp.trailing)
            make.height.equalTo(codeTextField.snp.height).multipliedBy(0.8)
            make.width.equalTo(codeTextField.snp.width).multipliedBy(0.2)
        }
    }
    
    
    // MARK: - Functions
    
    /// binding ViewModel
    private func bind(){
        
        codeTextField.rx.text
            .bind { [weak self] text in
                if let text = text{
                    self?.viewModel.codeRelay.accept(text)
                }
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .bind { [weak self] text in
                if let text = text{
                    self?.viewModel.emailRelay.accept(text)
                }
            }
            .disposed(by: disposeBag)
        
        certificatedEmailButton.rx.tap
            .bind { [weak self] in
                self?.sendingEmail()
            }
            .disposed(by: disposeBag)
        
        certificatedCodeButton.rx.tap
            .bind { [weak self] in
                self?.checkEmailCode()
                self?.codeTextField.resignFirstResponder()
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.clearAllSubject
                    .bind(onNext: { check in
                        if check{
                            guard let email = self?.emailTextField.text else { return }
                            SignUpDataViewModel.viewModel.emailRelay.accept(email)
                            let setNicknameViewController = SetNicknameViewController()
                            self?.navigationItem.backButtonTitle = " "
                            self?.navigationController?.pushViewController(setNicknameViewController, animated: true)
                        }
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
            }
            .disposed(by: disposeBag)
      
    }
    
    /// MARK: 이메일로 인증번호 전송
    private func sendingEmail(){
        viewModel.sendingEmail()
            .subscribe(
                onNext: { [weak self] in
                    self?.addCodeView()
                },
                onError: { [weak self] error in
                    self?.showErrorAlert(errorText: "다시 인증해주세요")
                })
            .disposed(by: disposeBag)
    }
    
    /// MARK: 인증 코드 인증
    private func checkEmailCode(){
        viewModel.checkEmailCode()
            .subscribe(
                onNext: { [weak self] check in
                    if check{
                        self?.nextButton.backgroundColor = .systemBlue
                        self?.nextButton.setTitleColor(.white, for: .normal)
                    }
                    else{
                        self?.showErrorAlert(errorText: "인증 코드를 다시 입력해주세요")
                    }
                },
                onError: { [weak self] error in
                    self?.showErrorAlert(errorText: "다시 요청해 주세요")
                })
            .disposed(by: disposeBag)
    }
    
    /// MARK: 인증 실패한 경우
    private func showErrorAlert(errorText: String){
        let sheet = UIAlertController(title: "오류 발생", message: errorText, preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default)
        
        sheet.addAction(success)
        self.present(sheet,animated: true)
    }
    
}
