//
//  SignUpViewController.swift
//  RF
//
//  Created by 박기용 on 2023/07/06.
//

import UIKit
import RxCocoa
import RxSwift

///  회원가입 첫번째 화면
///  아이디, 비밀번호 입력하는 화면
final class SignUpViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = SignUpViewModel()
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "회원 가입", style: .done, target: self, action: nil)
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
    
    private lazy var idLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .semibold)
        view.textColor = .black
        view.numberOfLines = 0
        view.text = "아이디"
        
        return view
    }()
    
    private lazy var idTextField: UITextField = {
        var view = UITextField()
        view.delegate = self
        view.borderStyle = UITextField.BorderStyle.none
        view.keyboardType = UIKeyboardType.emailAddress
        view.returnKeyType = UIReturnKeyType.done
        view.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        view.placeholder = " 아이디를 입력해주세요."
        return view
    }()
    
    private lazy var idCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.backgroundColor = UIColor(hexCode: "F5F5F5")
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var idUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var pwLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.numberOfLines = 0
        view.text = "비밀번호"
        view.font = .systemFont(ofSize: 20, weight: .semibold)
        return view
    }()
    
    private lazy var pwTextField: PasswordTextField = {
        var view = PasswordTextField()
        view.delegate = self
        view.borderStyle = UITextField.BorderStyle.none
        view.placeholder = " 비밀번호"
        return view
    }()
    
    private lazy var pwUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var pwConfirmLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .semibold)
        view.textColor = .black
        view.numberOfLines = 0
        view.text = "비밀번호 확인"
        
        return view
    }()
    
    private lazy var pwConfirmTextField: PasswordTextField = {
        var view = PasswordTextField()
        view.delegate = self
        view.borderStyle = UITextField.BorderStyle.none
        view.placeholder = " 비밀번호"
        return view
    }()
    
    private lazy var pwConfirmUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - view did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .white
        
        addSubViews()
        configureConstraints()
        addTargets()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func addSubViews() {
        view.addSubview(progressBar)
        
        view.addSubview(idLabel)
        view.addSubview(idTextField)
        view.addSubview(idCheckButton)
        view.addSubview(idUnderLine)
        
        view.addSubview(pwLabel)
        view.addSubview(pwTextField)
        view.addSubview(pwUnderLine)
        
        view.addSubview(pwConfirmLabel)
        view.addSubview(pwConfirmTextField)
        view.addSubview(pwConfirmUnderLine)
        
        view.addSubview(nextButton)
    }
    
    private func configureConstraints() {
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(idCheckButton.snp.leading).offset(-20)
            make.height.equalTo(47)
        }
        idCheckButton.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(idTextField.snp.height).multipliedBy(0.8)
            make.width.equalTo(idTextField.snp.width).multipliedBy(0.25)
        }
        idUnderLine.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(1)
        }
        
        
        pwLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(20)
        }
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(pwLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(47)
        }
        pwUnderLine.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(1)
        }
        
        
        pwConfirmLabel.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(20)
        }
        pwConfirmTextField.snp.makeConstraints { make in
            make.top.equalTo(pwConfirmLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(47)
        }
        pwConfirmUnderLine.snp.makeConstraints { make in
            make.top.equalTo(pwConfirmTextField.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(1)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(47)
        }
        
    }
    
    
    private func addTargets() {
        
        nextButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.checkTotalInformation()
            })
            .disposed(by: disposeBag)
        
        idCheckButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.checkOverlapId()
                    .subscribe(onNext:{ check in
                        self?.view.endEditing(true)
                        if check{
                            self?.showOverlapAlert(text: "사용 가능한 아이디 입니다.")
                        }
                        else{
                            self?.showOverlapAlert(text: "중복된 아이디 입니다.")
                        }
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
            }
            .disposed(by: disposeBag)
        
        idTextField.rx.text
            .bind { [weak self] id in
                if let text = id{
                    
                    self?.viewModel.idRelay.accept(text)
                }
            }
            .disposed(by: disposeBag)
        
        pwTextField.rx.text
            .bind { [weak self] pw in
                if let text = pw{
                    self?.viewModel.pwRelay.accept(text)
                }
            }
            .disposed(by: disposeBag)
        
        pwConfirmTextField.rx.text
            .bind {[weak self] pw in
                if let password = pw {
                    self?.viewModel.confirmPassword(password)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    /// MARK: viewModel binding 하는 함수
    private func bind(){
        viewModel.confirmPasswordRelay
            .bind(onNext: { [weak self] check in
                if check { // true: 비밀번호 일치
                    self?.nextButton.backgroundColor = .systemBlue
                    self?.nextButton.setTitleColor(.white, for: .normal)
                }
                else{ // false: 비밀번호가 일치하지 않는 경우 코드 작성
                    
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    /// MARK: 다음 버튼 눌렀을 때 모든 정보 입력했는 지 확인하는 함수
    private func checkTotalInformation(){
        viewModel.checkTotalInformation()
            .subscribe(onNext: { [weak self] check in
                if check {
                    let termsConditionsViewController = TermsConditionsViewController()
                    self?.navigationItem.backButtonTitle = " "
                    self?.navigationController?.pushViewController(termsConditionsViewController, animated: true)
                    SignUpDataViewModel.viewModel.idRelay.accept(self?.viewModel.idRelay.value ?? "")
                    SignUpDataViewModel.viewModel.pwRelay.accept(self?.viewModel.pwRelay.value ?? "")
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

extension SignUpViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == idTextField{
            viewModel.overlapCheckRelay.accept(false)
        }
    }
    
    
}


