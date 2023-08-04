//
//  SignUpViewController.swift
//  RF
//
//  Created by 박기용 on 2023/07/06.
//

import UIKit
import RxCocoa
import RxSwift

final class SignUpViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private func setNavigationTitle()
    {
        navigationItem.title = ""
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
    }
    
    
    
    // 프로그레스 바
    private lazy var progressBar: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.backgroundColor = UIColor(hexCode: "D1D1D1")
        pv.progress = 0.4
        return pv
    }()
    
    
    /// MARK: tipView Title Button
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.left")?.resize(newWidth: 15), for: .normal)
        btn.imageView?.tintColor = .systemBlue
        return btn
    }()
    // 메인 라벨
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
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
        view.placeholder = "아이디를 입력해주세요"

        return view
    }()
    private lazy var idCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 5
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
        view.placeholder = "비밀번호"
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
        view.text = "비밀번호 재입력"
        
        return view
    }()
    private lazy var pwConfirmTextField: PasswordTextField = {
        var view = PasswordTextField()
        view.delegate = self
        view.borderStyle = UITextField.BorderStyle.none
        view.placeholder = "비밀번호 확인"
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
        
        setNavigationTitle()
        
        addSubViews()
        configureConstraints()
        addTargets()
    }
    
    private func addSubViews() {
        view.addSubview(progressBar)
        view.addSubview(backButton)
        view.addSubview(mainLabel)
        
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
        
        // 프로그레스 바
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        
        // 뒤로가기 버튼
        backButton.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        // 메인 라벨
        mainLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.leading.equalTo(backButton.snp.trailing).offset(10)
        }
        
        
        
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(47)
        }
        idCheckButton.snp.makeConstraints { make in
            make.centerY.equalTo(idTextField.snp.centerY)
            make.trailing.equalTo(idTextField.snp.trailing).offset(-8)
            make.height.equalTo(32)
        }
        idUnderLine.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        
        pwLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(pwLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(idTextField.snp.horizontalEdges)
            make.height.equalTo(47)
        }
        pwUnderLine.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(0)
            make.horizontalEdges.equalTo(idTextField.snp.horizontalEdges)
            make.height.equalTo(1)
        }
        
        
        pwConfirmLabel.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        pwConfirmTextField.snp.makeConstraints { make in
            make.top.equalTo(pwConfirmLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(idTextField.snp.horizontalEdges)
            make.height.equalTo(47)
        }
        pwConfirmUnderLine.snp.makeConstraints { make in
            make.top.equalTo(pwConfirmTextField.snp.bottom).offset(0)
            make.horizontalEdges.equalTo(idTextField.snp.horizontalEdges)
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
        
        backButton.rx.tap
            .subscribe(onNext: {
                _ = self.navigationController?.popToRootViewController(animated: true)
            })
            .disposed(by: disposeBag)
    
        nextButton.rx.tap.subscribe(onNext: {
            self.navigationController?.pushViewController(TermsConditionsViewController(), animated: true)
        })
        .disposed(by: disposeBag)
        
    }

    
    // MARK: - Navigation


}

extension SignUpViewController : UITextFieldDelegate{
    
}


