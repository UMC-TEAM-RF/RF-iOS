//
//  ViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/02.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

/// 로그인 화면
final class SignInViewController: UIViewController {
    
    // MARK: - UI Property
    
    // 로고 이미지
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "rf_logo")?.resize(newWidth: 140)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    // 부제목 레이블 (글로벌한 대학 생활을 위한 첫 단계)
    private lazy var subTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Font.regular, size: 16)
        view.textColor = TextColor.first.color
        view.numberOfLines = 0
        view.text = "글로벌한 대학 생활을 위한 첫 단계"
        
        return view
    }()
    
    // 로고, 부제목 레이블, 제목 레이블을 스마트폰 화면 크기에 따라 유동적으로 크기를 조절하는 스택 뷰
    private lazy var logoStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [logoImageView, subTitleLabel])
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        sv.alignment = .center
        sv.spacing = 8
        return sv
    }()
    
    // 아이디 입력창
    private lazy var idTextField: UITextField = {
        var view = UITextField()
        view.placeholder = "아이디"
        view.delegate = self
        view.font = .systemFont(ofSize: 14)
        view.textColor = TextColor.first.color
        view.borderStyle = UITextField.BorderStyle.none
        view.keyboardType = UIKeyboardType.default
        view.returnKeyType = UIReturnKeyType.done
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return view
    }()
    private lazy var idUnderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = TextColor.secondary.color
        return view
    }()
    
    // 비밀번호 입력창 (눈 표시가 포함된 커스텀 텍스트필드)
    private lazy var pwTextField: PasswordTextField = {
        var view = PasswordTextField()
        view.placeholder = "비밀번호"
        view.delegate = self
        view.font = .systemFont(ofSize: 14)
        view.setColor(TextColor.first.color)
        view.setButtonColor(TextColor.secondary.color)
        view.borderStyle = UITextField.BorderStyle.none
        return view
    }()
    private lazy var pwUnderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = TextColor.secondary.color
        return view
    }()
    
    // 로그인 상태 유지하기 체크박스
    private lazy var autoLoginCheckBox: UICheckBox = {
        let button = UICheckBox()
        button.setTitle("  " + "로그인 상태 유지하기", for: .normal)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.setTitleColor(TextColor.first.color, for: .selected)
        button.setColor(UIColor.init(hexCode: "#555555"))
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    // 로그인 버튼
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = UIColor.init(hexCode: "#F5F5F5")
        button.layer.cornerRadius = 8
        return button
    }()
    
    //아이디 찾기
    private lazy var findIdButton: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 찾기", for: .normal)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    //비밀번호 재설정
    private lazy var resetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 재설정", for: .normal)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    //회원가입
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    //한국어설정
    private lazy var korLangButton: UIButton = {
        let button = UIButton()
        button.setTitle("KOR", for: .normal)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    //영어설정
    private lazy var engLangButton: UIButton = {
        let button = UIButton()
        button.setTitle("ENG", for: .normal)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    private lazy var firstDivLine: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor.init(hexCode: "#DFDFDF")
        return box
    }()
    
    private lazy var secondDivLine: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor.init(hexCode: "#DFDFDF")
        return box
    }()
    
    private lazy var thirdDivLine: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor.init(hexCode: "#DFDFDF")
        return box
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = SignInViewModel()
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubViews()
        configureConstraints()
        addTargets()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
    }
    
    private func configureConstraints() {
        
        logoStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.bottom.equalTo(idTextField.snp.top).offset(-40)
        }
        
        idTextField.snp.makeConstraints { make in
            make.bottom.equalTo(pwTextField.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(50)
            make.height.equalTo(47)
        }
        
        idUnderLineView.snp.makeConstraints { make in
            make.bottom.equalTo(pwTextField.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(50)
            make.height.equalTo(1)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(50)
            make.height.equalTo(47)
        }
        
        pwUnderLineView.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(50)
            make.height.equalTo(1)
        }
        
        autoLoginCheckBox.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(16)
            make.leading.equalTo(pwTextField.snp.leading)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(autoLoginCheckBox.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(50)
            make.height.equalTo(47)
        }
        
        findIdButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(32)
            make.trailing.equalTo(firstDivLine.snp.leading).offset(-16)
            make.height.equalTo(15)
        }
        
        firstDivLine.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(32)
            make.trailing.equalTo(resetPasswordButton.snp.leading).offset(-16)
            make.height.equalTo(15)
            make.width.equalTo(1)
        }
        
        resetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
        }
        
        secondDivLine.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(32)
            make.leading.equalTo(resetPasswordButton.snp.trailing).offset(16)
            make.height.equalTo(15)
            make.width.equalTo(1)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(32)
            make.leading.equalTo(secondDivLine.snp.trailing).offset(16)
            make.height.equalTo(15)
        }
        
        korLangButton.snp.makeConstraints { make in
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(32)
            make.trailing.equalTo(thirdDivLine.snp.leading).offset(-16)
            make.height.equalTo(15)
        }
        thirdDivLine.snp.makeConstraints { make in
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
            make.width.equalTo(1)
        }
        engLangButton.snp.makeConstraints { make in
            make.top.equalTo(resetPasswordButton.snp.bottom).offset(32)
            make.leading.equalTo(thirdDivLine.snp.trailing).offset(16)
            make.height.equalTo(15)
        }
    }
    
    private func addTargets() {
        loginButton.rx.tap
            .bind { [weak self] in
                self?.clickedLoginButton()
            }
            .disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .subscribe(onNext: { [weak self] in
            let signUpViewController = SignUpViewController()
                self?.navigationItem.backButtonTitle = " "
                self?.navigationController?.pushViewController(signUpViewController, animated: true)
            })
            .disposed(by: disposeBag)

    }


    
    /// MARK: 로그인 버튼 눌렀을 때 실행
    private func clickedLoginButton(){
        guard let inputId = idTextField.text else { return }
        guard let inputPW = pwTextField.text else { return }
        
        viewModel.idRelay
            .accept(inputId)
        
        viewModel.passwordRelay
            .accept(inputPW)
        
        viewModel.checkingLogin()
            .bind { check in
                if check{
                    // 로그인 성공 후 넘어가는 코드 작성
                    print("success login")
                    
                    // 내가 가입한 모임 ID들을 서버로부터 가져오고 realm에 저장 필요
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController())
                }
            }
            .disposed(by: disposeBag)
    }
}

extension SignInViewController: UITextFieldDelegate{
    
}
