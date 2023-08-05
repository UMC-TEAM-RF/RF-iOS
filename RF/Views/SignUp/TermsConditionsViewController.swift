//
//  TermsConditionsView.swift
//  RF
//
//  Created by 용용이 on 2023/07/12.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

/// 약관 동의 화면
final class TermsConditionsViewController: UIViewController {
    
    // MARK: - UI Property
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "회원 가입", style: .done, target: self, action: nil)
        btn.isEnabled = false
        btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .disabled)
        return btn
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var agreeAllCkeckBox: UIButton = {
        let button = UIButton()
        let offimage = UIImage(systemName: "square")
        let onimage = UIImage(systemName: "checkmark.square.fill")
        button.setTitle("  " + "아래 약관에 모두 동의합니다", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(offimage, for: .normal)
        button.setImage(onimage, for: .selected)
        button.imageView?.tintColor = .black
        button.addTarget(self, action: #selector(changeStateAll(_:)), for: .touchUpInside)
        return button
    }()
 
    private lazy var agreeAllUnderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var agreeServiceCkeckBox: UICheckBox1 = {
        let button = UICheckBox1()
        button.setTitle(title: "서비스이용약관 동의 (필수)")
        button.setEventFunction(function: {
            self.updateStateofAll()
        })
        return button
    }()
    
    private lazy var privacyServiceCkeckBox: UICheckBox1 = {
        let button = UICheckBox1()
        button.setTitle(title: "개인정보 수집이용 동의 (필수)")
        button.setEventFunction(function: {
            self.updateStateofAll()
        })
        return button
    }()
    
    private lazy var locationServiceCkeckBox: UICheckBox1 = {
        let button = UICheckBox1()
        button.setTitle(title: "사용자 위치 기반 정보 이용 동의 (선택)")
        button.setEventFunction(function: {
            self.updateStateofAll()
        })
        return button
    }()
    
    private lazy var nortificationServiceCkeckBox: UICheckBox1 = {
        let button = UICheckBox1()
        button.setTitle(title: "알림 동의 (선택)")
        button.setEventFunction(function: {
            self.updateStateofAll()
        })
        return button
    }()
    
    private lazy var realNameServiceCkeckBox: UICheckBox1 = {
        let button = UICheckBox1()
        button.setTitle(title: "본인 명의를 이용하여 가입을 진행하겠습니다.")
        button.setWeight(weight: .bold)
        button.setEventFunction(function: {
            self.updateStateofAll()
        })
        return button
    }()
    
    private lazy var realNameLabelBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private lazy var realNameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .black
        view.numberOfLines = 0
        view.text = "본인 명의를 이용하여 가입을 진행하겠습니다. 본인 명의를 이용하여 가입을 진행하겠습니다. 본인 명의를 이용하여 가입을 진행하겠습니다.본인 명의를 이용하여 가입을 진행하겠습니다.본인 명의를 이용하여 가입을 진행하겠습니다.본인 명의를 이용하여 가입을 진행하겠습니다.본인 명의를 이용하여 가입을 진행하겠습니다."
        return view
    }()
    
    private lazy var ageServiceCkeckBox: UICheckBox1 = {
        let button = UICheckBox1()
        button.setTitle(title: "만 14세 이상입니다.")
        button.setWeight(weight: .bold)
        button.setEventFunction(function: {
            self.updateStateofAll()
        })
        return button
    }()
    
    private lazy var ageLabelBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private lazy var ageLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .black
        view.numberOfLines = 0
        view.text = "본인 명의를 이용하여 가입을 진행하겠습니다. 본인 명의를 이용하여 가입을 진행하겠습니다. 본인 명의를 이용하여 가입을 진행하겠습니다.본인 명의를 이용하여 가입을 진행하겠습니다.본인 명의를 이용하여 가입을 진행하겠습니다.본인 명의를 이용하여 가입을 진행하겠습니다.본인 명의를 이용하여 가입을 진행하겠습니다."
        
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        buttonInactivate(button)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Property
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .systemBackground
        
        addSubviews()
        configureConstraints()
        clickedButtons()
    }
    
    // MARK: - addSubviews
    
    private func addSubviews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        // 컨테이너 뷰
        containerView.addSubview(agreeAllCkeckBox)
        containerView.addSubview(agreeAllUnderLineView)
        
        containerView.addSubview(agreeServiceCkeckBox)
        containerView.addSubview(privacyServiceCkeckBox)
        containerView.addSubview(locationServiceCkeckBox)
        containerView.addSubview(nortificationServiceCkeckBox)
        
        containerView.addSubview(realNameServiceCkeckBox)
        containerView.addSubview(realNameLabelBackgroundView)
        realNameLabelBackgroundView.addSubview(realNameLabel)
        
        containerView.addSubview(ageServiceCkeckBox)
        containerView.addSubview(ageLabelBackgroundView)
        ageLabelBackgroundView.addSubview(ageLabel)
        
        containerView.addSubview(nextButton)
    }
    
    // MARK: - configureConstraints
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        agreeAllCkeckBox.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(20)
        }
        
        agreeAllUnderLineView.snp.makeConstraints { make in
            make.top.equalTo(agreeAllCkeckBox.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        agreeServiceCkeckBox.snp.makeConstraints { make in
            make.top.equalTo(agreeAllUnderLineView.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(20)
        }
        
        privacyServiceCkeckBox.snp.makeConstraints { make in
            make.top.equalTo(agreeServiceCkeckBox.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(20)
        }
        
        locationServiceCkeckBox.snp.makeConstraints { make in
            make.top.equalTo(privacyServiceCkeckBox.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(20)
        }
        
        nortificationServiceCkeckBox.snp.makeConstraints { make in
            make.top.equalTo(locationServiceCkeckBox.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(20)
        }
        
        realNameServiceCkeckBox.snp.makeConstraints { make in
            make.top.equalTo(nortificationServiceCkeckBox.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(20)
        }
        
        realNameLabelBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(realNameServiceCkeckBox.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        realNameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        ageServiceCkeckBox.snp.makeConstraints { make in
            make.top.equalTo(realNameLabelBackgroundView.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(20)
        }
        
        ageLabelBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(ageServiceCkeckBox.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(ageLabelBackgroundView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
            make.height.equalTo(47)
        }
        
    }
    
    @objc
    private func changeStateAll(_ sender: UIButton) {
        agreeAllCkeckBox.isSelected = !agreeAllCkeckBox.isSelected
        if(agreeAllCkeckBox.isSelected){
            agreeServiceCkeckBox.isSelected = true
            privacyServiceCkeckBox.isSelected = true
            locationServiceCkeckBox.isSelected = true
            nortificationServiceCkeckBox.isSelected = true
            realNameServiceCkeckBox.isSelected = true
            ageServiceCkeckBox.isSelected = true
            
            
            phoneButtonActivate()
        }else{
            agreeServiceCkeckBox.isSelected = false
            privacyServiceCkeckBox.isSelected = false
            locationServiceCkeckBox.isSelected = false
            nortificationServiceCkeckBox.isSelected = false
            realNameServiceCkeckBox.isSelected = false
            ageServiceCkeckBox.isSelected = false
            
            buttonInactivate(nextButton)
        }
    }
    
    private func updateStateofAll(){
        if(agreeServiceCkeckBox.isSelected
           && privacyServiceCkeckBox.isSelected
           && locationServiceCkeckBox.isSelected
           && nortificationServiceCkeckBox.isSelected
           && realNameServiceCkeckBox.isSelected
           && ageServiceCkeckBox.isSelected){
            agreeAllCkeckBox.isSelected = true
            
            phoneButtonActivate()
        }
        else{
            agreeAllCkeckBox.isSelected = false
            
            buttonInactivate(nextButton)
        }
    }
    
    private func phoneButtonActivate(){
        nextButton.backgroundColor = .blue
        nextButton.setTitleColor(.white, for: .normal)
    }
    
    
    private func buttonInactivate(_ button : UIButton){
        button.backgroundColor = .systemGray
        button.setTitleColor(.black, for: .normal)
    }
    
    /// MARK: 휴대폰 인증, 아이핀 인증 버튼 눌렀을 때 실행
    private func clickedButtons(){
        nextButton.rx.tap
            .bind { [weak self] in
                let chooseUniversityViewController = ChooseUniversityViewController()
                self?.navigationItem.backButtonTitle = " "
                self?.navigationController?.pushViewController(chooseUniversityViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}



