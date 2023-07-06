//
//  ViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/02.
//

import UIKit

final class SignInViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - UI Property
    
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "LogoImage")
        view.contentMode = .scaleToFill
        return view
    }()
    private let subTitlelabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .gray
        view.numberOfLines = 0
        //view.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        view.text = "글로벌한 대학 생활을 위한 첫 단계"
        return view
    }()
    
    private let mainTitlelabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 39)
        view.textColor = .gray
        view.numberOfLines = 0
        //view.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        view.text = "알프"
        return view
    }()
    
    lazy var idTextField: UITextField = {
        var view = UITextField()
        view.placeholder = "아이디"
        view.delegate = self
        view.borderStyle = UITextField.BorderStyle.roundedRect
        view.keyboardType = UIKeyboardType.default
        view.returnKeyType = UIReturnKeyType.done
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        return view
    }()
    lazy var pwdTextField: PasswordTextField = {
        var view = PasswordTextField()
        view.placeholder = "비밀번호"
        view.delegate = self
        view.borderStyle = UITextField.BorderStyle.roundedRect
        //view.keyboardType = UIKeyboardType.default
        //view.returnKeyType = UIReturnKeyType.done
        //view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return view
    }()
    
    private lazy var autologinCkeckBox: UICheckBox = {
        let button = UICheckBox()
        button.setTitle("로그인 상태 유지하기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    
    private lazy var triplebuttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [findIDButton, resetPasswordButton, SignUpButton])
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        sv.spacing = 15
        return sv
    }()
    private lazy var findIDButton: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 찾기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    private lazy var resetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 재설정", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    private lazy var SignUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    
    
    
    private lazy var languageStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [Lang1Button, Lang2Button])
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        sv.spacing = 15
        return sv
    }()
    private lazy var Lang1Button: UIButton = {
        let button = UIButton()
        button.setTitle("KOR", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    private lazy var Lang2Button: UIButton = {
        let button = UIButton()
        button.setTitle("ENG", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
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
        
        view.backgroundColor = .systemBackground
        
        addSubViews()
        configureConstraints()
        addTargets()
    }

    private func addSubViews() {
        view.addSubview(logoImageView)
        view.addSubview(subTitlelabel)
        view.addSubview(mainTitlelabel)
        view.addSubview(idTextField)
        view.addSubview(pwdTextField)
        
        view.addSubview(autologinCkeckBox)
        view.addSubview(loginButton)
        
        view.addSubview(triplebuttonStackView)
        view.addSubview(languageStackView)
        
        
        view.addSubview(bottomStackView)
    }
    private func configureConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(139)
            make.width.equalTo(121)
        }
        
        subTitlelabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        mainTitlelabel.snp.makeConstraints { make in
            make.top.equalTo(subTitlelabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        idTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        pwdTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        autologinCkeckBox.snp.makeConstraints { make in
            make.top.equalTo(pwdTextField.snp.bottom).offset(16)
            make.left.equalTo(pwdTextField.snp.left)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(autologinCkeckBox.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(47)
        }
        triplebuttonStackView.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        languageStackView.snp.makeConstraints { make in
            make.top.equalTo(triplebuttonStackView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
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
    }
    
    @objc private func onboardingButtonTapped() {
        navigationController?.pushViewController(SetNicknameViewController(), animated: true)
    }

    @objc private func homeButtonTapped() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController())
    }
}




class PasswordTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.isSecureTextEntry = true
        
        //show/hide button
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.imageView?.tintColor = .lightGray
        rightView = button
        rightViewMode = .always
        button.addTarget(self, action: #selector(showHidePassword(_:)), for: .touchUpInside)
    }
    
    @objc private func showHidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isSecureTextEntry = !sender.isSelected
    }
    
}

class UICheckBox: UIButton {
    var isChecked : Bool! = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.setImage(UIImage(systemName: "square"), for: .normal)
        self.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        self.imageView?.tintColor = .darkGray
        self.addTarget(self, action: #selector(showHidePassword(_:)), for: .touchUpInside)
    }
    
    @objc private func showHidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}
