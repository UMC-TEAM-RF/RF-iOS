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
    private lazy var subTitlelabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .gray
        view.numberOfLines = 0
        //view.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        view.text = "글로벌한 대학 생활을 위한 첫 단계"
        
        return view
    }()
    
    private lazy var mainTitlelabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 39)
        view.textColor = .gray
        view.numberOfLines = 0
        //view.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        view.text = "알프"
        return view
    }()
    
    private lazy var LogoStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [logoImageView, subTitlelabel, mainTitlelabel])
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
    private lazy var idunderlineView: UIView = {
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
    private lazy var pwunderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var autologinCkeckBox: UICheckBox = {
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
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        return button
    }()
    
    
//    private lazy var triplebuttonStackView: UIStackView = {
//        let sv = UIStackView(arrangedSubviews: [findIDButton, resetPasswordButton, SignUpButton])
//        sv.axis = .horizontal
//        sv.alignment = .fill
//        sv.distribution = .equalSpacing
//        sv.spacing = 20
//        return sv
//    }()
    private lazy var findIDButton: UIButton = {
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
    private lazy var SignUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    
    
//    private lazy var languageStackView: UIStackView = {
//        let sv = UIStackView(arrangedSubviews: [Lang1Button, Lang2Button])
//        sv.axis = .horizontal
////        sv.alignment = .
//        sv.distribution = .fill
//        sv.spacing = 15
//        return sv
//    }()
    private lazy var Lang1Button: UIButton = {
        let button = UIButton()
        button.setTitle("KOR", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    private lazy var Lang2Button: UIButton = {
        let button = UIButton()
        button.setTitle("ENG", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    
    private lazy var vline1: UIView = {
        let box = UIView()
        box.backgroundColor = .gray
        return box
    }()
    private lazy var vline2: UIView = {
        let box = UIView()
        box.backgroundColor = .gray
        return box
    }()
    private lazy var vline3: UIView = {
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
        view.addSubview(LogoStackView)
        //view.addSubview(logoImageView)
        //view.addSubview(subTitlelabel)
        //view.addSubview(mainTitlelabel)
        
        view.addSubview(idTextField)
        view.addSubview(idunderlineView)
        view.addSubview(pwTextField)
        view.addSubview(pwunderlineView)
        
        
        view.addSubview(autologinCkeckBox)
        view.addSubview(loginButton)
        
        view.addSubview(findIDButton)
        view.addSubview(vline1)
        view.addSubview(resetPasswordButton)
        view.addSubview(vline2)
        view.addSubview(SignUpButton)
        
        view.addSubview(Lang1Button)
        view.addSubview(vline3)
        view.addSubview(Lang2Button)
        
        
        view.addSubview(bottomStackView)
    }
    private func configureConstraints() {
        
        LogoStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.bottom.equalTo(idTextField.snp.top).offset(-15)
        }
//        logoImageView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.centerX.equalToSuperview()
//            make.height.equalTo(139)
//            make.width.equalTo(121)
//        }
//
//        subTitlelabel.snp.makeConstraints { make in
//            make.top.equalTo(logoImageView.snp.bottom).offset(8)
//            make.centerX.equalToSuperview()
//        }
//        mainTitlelabel.snp.makeConstraints { make in
//            make.top.equalTo(subTitlelabel.snp.bottom).offset(8)
//            make.centerX.equalToSuperview()
//        }
        
        
        
        idTextField.snp.makeConstraints { make in
            make.bottom.equalTo(pwTextField.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(47)
        }
        idunderlineView.snp.makeConstraints { make in
            make.bottom.equalTo(pwTextField.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(1)
        }
        pwTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(47)
        }
        pwunderlineView.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(1)
        }
        
        
        autologinCkeckBox.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(16)
            make.left.equalTo(pwTextField.snp.left)
        }
        
        
        
        
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(autologinCkeckBox.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(47)
        }
        
        
        
        findIDButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.right.equalTo(vline1.snp.left).offset(-8)
            make.height.equalTo(15)
        }
        vline1.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.right.equalTo(resetPasswordButton.snp.left).offset(-8)
            make.height.equalTo(15)
            make.width.equalTo(1)
        }
        resetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
        }
        vline2.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.left.equalTo(resetPasswordButton.snp.right).offset(8)
            make.height.equalTo(15)
            make.width.equalTo(1)
        }
        SignUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.left.equalTo(vline2.snp.right).offset(8)
            make.height.equalTo(15)
        }

        
        
        Lang1Button.snp.makeConstraints { make in
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(16)
            make.right.equalTo(vline3.snp.left).offset(-8)
            make.height.equalTo(15)
        }
        vline3.snp.makeConstraints { make in
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
            make.width.equalTo(1)
        }
        Lang2Button.snp.makeConstraints { make in
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(16)
            make.left.equalTo(vline3.snp.right).offset(8)
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
        SignUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
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
//        if view is GIDSignInButton {
//            return
//        }
        view.endEditing(true)
    }
}
