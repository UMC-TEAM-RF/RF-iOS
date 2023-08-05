// UserinfoSelfViewController.swift
//  RF
//
//  Created by 나예은 on 2023/07/19.
//
//

import UIKit
import SnapKit
import RxSwift

/// 한줄 소개 입력하는 화면
final class UserInfoSelfViewController: UIViewController {
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "한 줄 소개", style: .done, target: self, action: nil)
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
    
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = "  " + "나를 나타낼 수 있는 대표적 키워드를 적어주세요."
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(hexCode: "#3C3A3A")
        label.numberOfLines = 1
        return label
    }()
    
    // bottomLine 뷰를 위한 프로퍼티 추가
    private let bottomLine: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .gray
        return lineView
    }()
    
    // textField와 bottomLine을 뷰 컨트롤러의 뷰에 추가합니다.
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.borderStyle = .none
        field.layer.cornerRadius = 5
        field.placeholder = "   " + "한 줄 소개를 작성해주세요!"
        field.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        field.backgroundColor = .clear
        field.textColor = UIColor(hexCode: "#A0A0A0")
        field.addSubview(bottomLine)
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        configureConstraints(for: field, and: bottomLine)
        
        return field
    }()
    
    // bottomLine의 제약 조건을 설정하는 헬퍼 함수
    private func configureConstraints(for textField: UITextField, and bottomLine: UIView) {
        bottomLine.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "이후에 변경할 수 없으니 신중히 결정해주세요!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(hexCode: "#A0A0A0")
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(UIColor(hexCode: "#3C3A3A") , for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.backgroundColor =  UIColor(hexCode: "#F5F5F5")
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = UserInfoSelfViewModel()

    // MARK: - init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = .black
        
        addSubviews()
        clickedButtons()
    }
    
    
    private func addSubviews() {
        view.addSubview(progressBar)
        
        view.addSubview(subLabel) // 나를 나타낼 수 있는 대표적 키워드를 적어주세요
        view.addSubview(textField) // 한 줄 소개를 작성해주세요!
        view.addSubview(warningLabel) // 이후에 변경할 수 없으니 신중히 결정해주세요!
        view.addSubview(nextButton) // 다음
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        // 나를 나타낼 수 있는 대표적 키워드를 적어주세요
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // 한 줄 소개를 작성해주세요!
        textField.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        // 이후에 변경할 수 없으니 신중히 결정해주세요!
        warningLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-20)
            make.leading.trailing.equalToSuperview().inset(70)
        }
    
        //다음
        nextButton.snp.makeConstraints { make in
            make.leading.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(48)
        }
    }
    
    /// MARK: 버튼 눌렀을 때 실행
    private func clickedButtons(){
        nextButton.rx.tap
            .bind { [weak self] in
                self?.checkIntroduce()
            }
            .disposed(by: disposeBag)
        
        textField.rx.text
            .bind { [weak self] introduce in
                if let introduce = introduce{
                    self?.viewModel.introduceSelfRelay.accept(introduce)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    /// MARK: 한줄 소개 작성했는 지 확인
    private func checkIntroduce(){
        viewModel.checkIntroduce()
            .subscribe(onNext: { [weak self] check in
                if check{
                    let userInfoViewController = UserInfoViewController()
                    self?.navigationItem.backButtonTitle = " "
                    self?.navigationController?.pushViewController(userInfoViewController, animated: true)
                    
                    SignUpDataViewModel.viewModel.introduceSelfRelay.accept(self?.viewModel.introduceSelfRelay.value ?? "")
                }
                else{
                    self?.showAlert(text: "한 줄 소개를 입력해 주세요!")
                }
            })
            .disposed(by: disposeBag)
    }
    
    /// MARK: 한줄 소개 안쓴 경우
    private func showAlert(text: String){
        let sheet = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default)
        
        sheet.addAction(success)
        self.present(sheet,animated: true)
    }
}


