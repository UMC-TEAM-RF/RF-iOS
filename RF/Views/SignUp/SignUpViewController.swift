//
//  SignUpViewController.swift
//  RF
//
//  Created by 박기용 on 2023/07/06.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    private lazy var idLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .black
        view.numberOfLines = 0
        //view.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        view.text = "아이디"
        
        return view
    }()
    private lazy var idTextField: UITextField = {
        var view = UITextField()
        //view.placeholder = "아이디"
        view.delegate = self
        //view.font = .systemFont(ofSize: 15)
        view.borderStyle = UITextField.BorderStyle.none
        view.keyboardType = UIKeyboardType.emailAddress
        view.returnKeyType = UIReturnKeyType.done
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)

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
        //view.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        view.text = "비밀번호"
        
        return view
    }()
    private lazy var pwTextField: PasswordTextField = {
        var view = PasswordTextField()
        //view.placeholder = "비밀번호"
        view.delegate = self
        //view.font = .systemFont(ofSize: 12)
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
        //view.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        view.text = "비밀번호 확인"
        
        return view
    }()
    private lazy var pwConfirmTextField: PasswordTextField = {
        var view = PasswordTextField()
        //view.placeholder = "비밀번호 확인"
        view.delegate = self
        //view.font = .systemFont(ofSize: 12)
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
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "회원가입"
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        addSubViews()
        configureConstraints()
        addTargets()
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
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(80)
            make.height.equalTo(47)
        }
        idUnderLine.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(idCheckButton.snp.leading).offset(-16)
            make.height.equalTo(1)
        }
        
        
        pwLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(pwLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(idCheckButton.snp.leading).offset(-16)
            make.height.equalTo(47)
        }
        pwUnderLine.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(idCheckButton.snp.leading).offset(-16)
            make.height.equalTo(1)
        }
        
        
        pwConfirmLabel.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        pwConfirmTextField.snp.makeConstraints { make in
            make.top.equalTo(pwConfirmLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(idCheckButton.snp.leading).offset(-16)
            make.height.equalTo(47)
        }
        pwConfirmUnderLine.snp.makeConstraints { make in
            make.top.equalTo(pwConfirmTextField.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(idCheckButton.snp.leading).offset(-16)
            make.height.equalTo(1)
        }
        
        
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(47)
        }
        
    }
    
    
    private func addTargets() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
//        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
//        SignUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    @objc private func nextButtonTapped() {
        navigationController?.pushViewController(TermsConditionsViewController(), animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SignUpViewController : UITextFieldDelegate{
    
}


