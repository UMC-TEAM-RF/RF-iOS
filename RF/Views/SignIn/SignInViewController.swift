//
//  ViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/02.
//

import UIKit

final class SignInViewController: UIViewController {
    
    // MARK: - UI Property
    
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "LogoImage")
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var subTitleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .gray
        view.numberOfLines = 0
        view.text = "글로벌한 대학 생활을 위한 첫 단계"
        
        return view
    }()
    
    private lazy var mainTitleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 39)
        view.textColor = .gray
        view.numberOfLines = 0
        view.text = "알프"
        return view
    }()
    
    private lazy var logoStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [logoImageView, subTitleLabel, mainTitleLabel])
        sv.axis = .vertical
        sv.distribution = .equalCentering
        sv.alignment = .center
        sv.spacing = 8
        return sv
    }()
    
    
    
    
    
    
    private lazy var idTextField: UITextField = {
        var view = UITextField()
        view.placeholder = "아이디"
        view.delegate = self
        view.font = .systemFont(ofSize: 12)
        view.borderStyle = UITextField.BorderStyle.none
        view.keyboardType = UIKeyboardType.default
        view.returnKeyType = UIReturnKeyType.done
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return view
    }()
    private lazy var idUnderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    private lazy var pwTextField: PasswordTextField = {
        var view = PasswordTextField()
        view.placeholder = "비밀번호"
        view.delegate = self
        view.font = .systemFont(ofSize: 12)
        view.borderStyle = UITextField.BorderStyle.none
        return view
    }()
    private lazy var pwUnderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var autoLoginCheckBox: UICheckBox = {
        let button = UICheckBox()
        button.setTitle("  " + "로그인 상태 유지하기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    private lazy var findIdButton: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 찾기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    private lazy var resetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 재설정", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    private lazy var korLangButton: UIButton = {
        let button = UIButton()
        button.setTitle("KOR", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    private lazy var engLangButton: UIButton = {
        let button = UIButton()
        button.setTitle("ENG", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    
    private lazy var firstDivLine: UIView = {
        let box = UIView()
        box.backgroundColor = .gray
        return box
    }()
    private lazy var secondDivLine: UIView = {
        let box = UIView()
        box.backgroundColor = .gray
        return box
    }()
    private lazy var thirdDivLine: UIView = {
        let box = UIView()
        box.backgroundColor = .gray
        return box
    }()
    
    
    
    private lazy var bottomStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [homeButton, onboardingButton])
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    private lazy var onboardingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Onboarding", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Home", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        
        view.backgroundColor = .systemBackground
        
        addSubViews()
        configureConstraints()
        addTargets()
    }

    private func addSubViews() {
        view.addSubview(logoStackView)
        
        view.addSubview(idTextField)
        view.addSubview(idUnderLineView)
        view.addSubview(pwTextField)
        view.addSubview(pwUnderLineView)
        
        
        view.addSubview(autoLoginCheckBox)
        view.addSubview(loginButton)
        
        view.addSubview(findIdButton)
        view.addSubview(firstDivLine)
        view.addSubview(resetPasswordButton)
        view.addSubview(secondDivLine)
        view.addSubview(signUpButton)
        
        view.addSubview(korLangButton)
        view.addSubview(thirdDivLine)
        view.addSubview(engLangButton)
        
        
        view.addSubview(bottomStackView)
    }
    private func configureConstraints() {
        
        logoStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.bottom.equalTo(idTextField.snp.top).offset(-15)
        }
        
        idTextField.snp.makeConstraints { make in
            make.bottom.equalTo(pwTextField.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(47)
        }
        idUnderLineView.snp.makeConstraints { make in
            make.bottom.equalTo(pwTextField.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(1)
        }
        pwTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(47)
        }
        pwUnderLineView.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(1)
        }
        
        
        autoLoginCheckBox.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(16)
            make.leading.equalTo(pwTextField.snp.leading)
        }
        
        
        
        
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(autoLoginCheckBox.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(47)
        }
        
        
        
        findIdButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.trailing.equalTo(firstDivLine.snp.leading).offset(-8)
            make.height.equalTo(15)
        }
        firstDivLine.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.trailing.equalTo(resetPasswordButton.snp.leading).offset(-8)
            make.height.equalTo(15)
            make.width.equalTo(1)
        }
        resetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
        }
        secondDivLine.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.leading.equalTo(resetPasswordButton.snp.trailing).offset(8)
            make.height.equalTo(15)
            make.width.equalTo(1)
        }
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.leading.equalTo(secondDivLine.snp.trailing).offset(8)
            make.height.equalTo(15)
        }

        
        
        korLangButton.snp.makeConstraints { make in
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(16)
            make.trailing.equalTo(thirdDivLine.snp.leading).offset(-8)
            make.height.equalTo(15)
        }
        thirdDivLine.snp.makeConstraints { make in
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
            make.width.equalTo(1)
        }
        engLangButton.snp.makeConstraints { make in
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(16)
            make.leading.equalTo(thirdDivLine.snp.trailing).offset(8)
            make.height.equalTo(15)
        }
        
        
        bottomStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
    }
    
    private func addTargets() {
        onboardingButton.addTarget(self, action: #selector(onboardingButtonTapped), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc private func onboardingButtonTapped() {
        navigationController?.pushViewController(SetNicknameViewController(), animated: true)
    }

    @objc private func homeButtonTapped() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController())
    }
    
    @objc private func signUpButtonTapped() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
}




extension SignInViewController : UITextFieldDelegate{
    
}



extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(SignInViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
