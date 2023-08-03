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
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "회원 가입", style: .done, target: self, action: nil)
        btn.isEnabled = false
        btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .disabled)
        return btn
    }()
    
    private lazy var idLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
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
        
        return view
    }()
    private lazy var idCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    private lazy var idUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var pwLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .black
        view.numberOfLines = 0
        view.text = "비밀번호"
        
        return view
    }()
    
    private lazy var pwTextField: PasswordTextField = {
        var view = PasswordTextField()
        view.delegate = self
        view.borderStyle = UITextField.BorderStyle.none
        return view
    }()
    
    private lazy var pwUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var pwConfirmLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .black
        view.numberOfLines = 0
        view.text = "비밀번호 확인"
        
        return view
    }()
    
    private lazy var pwConfirmTextField: PasswordTextField = {
        var view = PasswordTextField()
        view.delegate = self
        view.borderStyle = UITextField.BorderStyle.none
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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .white
        
        addSubViews()
        configureConstraints()
        addTargets()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func addSubViews() {
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
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalToSuperview().offset(16)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(idCheckButton.snp.leading).offset(-16)
            make.height.equalTo(47)
        }
        idCheckButton.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(16)
            make.leading.equalTo(idTextField.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(47)
        }
        idUnderLine.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(idTextField.snp.trailing)
            make.height.equalTo(1)
        }
        
        
        pwLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(pwLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(idTextField.snp.trailing)
            make.height.equalTo(47)
        }
        pwUnderLine.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(idTextField.snp.trailing)
            make.height.equalTo(1)
        }
        
        
        pwConfirmLabel.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        pwConfirmTextField.snp.makeConstraints { make in
            make.top.equalTo(pwConfirmLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(idTextField.snp.trailing)
            make.height.equalTo(47)
        }
        pwConfirmUnderLine.snp.makeConstraints { make in
            make.top.equalTo(pwConfirmTextField.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(idTextField.snp.trailing)
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
            .subscribe(onNext: { [weak self] in
                let termsConditionsViewController = TermsConditionsViewController()
                self?.navigationItem.backButtonTitle = " "
                self?.navigationController?.pushViewController(termsConditionsViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    
    
    // MARK: - Navigation
    
    
}

extension SignUpViewController : UITextFieldDelegate{
    
}


