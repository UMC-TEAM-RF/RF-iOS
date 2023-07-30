//
//  CreateMeetingNameViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/10.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SetMeetingNameViewController: UIViewController {
    
    // MARK: - UI Property
    
    // 네비게이션 바
    private lazy var navigationBar: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.titleLabelText = "모임 생성"
        view.delegate = self
        return view
    }()
    
    // 프로그레스 바
    private lazy var progressBar: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.backgroundColor = UIColor(hexCode: "D1D1D1")
        pv.progress = 0.25
        return pv
    }()

    // 메인 라벨
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 명을 입력해 주세요."
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    // 모임 명 입력 창
    private lazy var meetingNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.borderStyle = .none
        tf.backgroundColor = .clear
        tf.delegate = self
        tf.addHorizontalPadding(5)
        tf.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return tf
    }()
    
    private lazy var textFieldUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // 서브 라벨
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = "변경이 불가하니 신중하게 작성해 주세요!"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .systemGray6
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    private let placeholder = "2글자 이상"
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
        
        addSubviews()
        configureConstraints()
        addTargets()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(navigationBar)
        view.addSubview(progressBar)
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        view.addSubview(meetingNameTextField)
        view.addSubview(textFieldUnderLine)
        view.addSubview(nextButton)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        // 네비게이션 바
        navigationBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        // 프로그레스 바
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
        
        // 메인 라벨
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(35)
            make.leading.equalToSuperview().inset(30)
        }
        
        meetingNameTextField.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(25)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        textFieldUnderLine.snp.makeConstraints { make in
            make.top.equalTo(meetingNameTextField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(meetingNameTextField)
            make.height.equalTo(1)
        }
        
        // 서브 라벨
        subLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
    
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - addTargets()
    
    private func addTargets() {
        nextButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(SetInterestViewController(), animated: true)
            })
            .disposed(by: disposeBag)
        
        meetingNameTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: {
                //if $0 == "" || $0.split(separator: " ").count == 0 {
                if $0.trimmingCharacters(in: .whitespaces).count < 2 {
                    self.nextButton.backgroundColor = .systemGray6
                    self.nextButton.setTitleColor(.black, for: .normal)
                    self.nextButton.isEnabled = false
                } else {
                    self.nextButton.backgroundColor = .tintColor
                    self.nextButton.setTitleColor(.white, for: .normal)
                    self.nextButton.isEnabled = true
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Ext: NavigationDelegate

extension SetMeetingNameViewController: NavigationBarDelegate {
    func backButtonTapped() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Ext: TextFieldDelegate

extension SetMeetingNameViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if text.trimmingCharacters(in: .whitespaces).isEmpty {
            textField.text = nil
            nextButton.backgroundColor = .systemGray6
            nextButton.setTitleColor(.black, for: .normal)
            nextButton.isEnabled = false
        }
    }
}


