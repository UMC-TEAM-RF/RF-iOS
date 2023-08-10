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
    private let viewModel = SetMeetingNameViewModel()
    private let placeholder = "2글자 이상"
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        updateTitleView(title: "모임 생성")
        setupCustomBackButton()
        
        addSubviews()
        configureConstraints()
        addTargets()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(progressBar)
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        view.addSubview(meetingNameTextField)
        view.addSubview(textFieldUnderLine)
        view.addSubview(nextButton)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        
        // 프로그레스 바
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
        
        // 메인 라벨
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(40)
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
            .withLatestFrom(viewModel.isValid())
            .filter { $0 }
            .bind(onNext: { [weak self] _ in
                self?.navigationController?.pushViewController(SetInterestViewController(), animated: true)
            })
            .disposed(by: disposeBag)

        meetingNameTextField.rx.text
            .bind(onNext: { [weak self] text in
                if let text = text {
                    CreateViewModel.viewModel.meetingName.accept(text)
                    self?.viewModel.meetingName.accept(text)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.isValid()
            .subscribe(onNext: { [weak self] isValid in
                self?.nextButton.backgroundColor = isValid ? .tintColor : .systemGray6
                self?.nextButton.setTitleColor(isValid ? .white : .black, for: .normal)
                self?.nextButton.isEnabled = isValid
            })
            .disposed(by: disposeBag)
    }

}
