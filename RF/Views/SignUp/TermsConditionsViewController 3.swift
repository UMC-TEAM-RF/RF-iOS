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


final class TermsConditionsViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.bounces = true
//        scrollView.isScrollEnabled = true
//        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var agreeAllCkeckBox: UIButton = {
        let button = UIButton()
        let offimage = UIImage(systemName: "square")
            //?.resize(newWidth: 25, newHeight: 25)
        let onimage = UIImage(systemName: "checkmark.square.fill")
            //?.resize(newWidth: 25, newHeight: 25)
        
        button.setTitle("  " + "아래 약관에 모두 동의합니다", for: .normal)
        button.setTitleColor(.black, for: .normal)
        //button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        button.setImage(offimage, for: .normal)
        button.setImage(onimage, for: .selected)
        button.imageView?.tintColor = .black
        
        button.addTarget(self, action: #selector(changeStateAll(_:)), for: .touchUpInside)
        return button
    }()
    @objc private func changeStateAll(_ sender: UIButton) {
        agreeAllCkeckBox.isSelected = !agreeAllCkeckBox.isSelected
        if(agreeAllCkeckBox.isSelected){
            agreeServiceCkeckBox.isSelected = true
            privacyServiceCkeckBox.isSelected = true
            locationServiceCkeckBox.isSelected = true
            nortificationServiceCkeckBox.isSelected = true
            realNameServiceCkeckBox.isSelected = true
            ageServiceCkeckBox.isSelected = true
            
            
            phoneButtonActivate()
            iPinButtonActivate()
        }else{
            agreeServiceCkeckBox.isSelected = false
            privacyServiceCkeckBox.isSelected = false
            locationServiceCkeckBox.isSelected = false
            nortificationServiceCkeckBox.isSelected = false
            realNameServiceCkeckBox.isSelected = false
            ageServiceCkeckBox.isSelected = false
            
            buttonInactivate(phoneNextButton)
            buttonInactivate(iPinNextButton)
        }
    }
    private lazy var agreeAllUnderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    
    private func updateStateofAll(){
        if(agreeServiceCkeckBox.isSelected
           && privacyServiceCkeckBox.isSelected
           && locationServiceCkeckBox.isSelected
           && nortificationServiceCkeckBox.isSelected
           && realNameServiceCkeckBox.isSelected
           && ageServiceCkeckBox.isSelected){
            agreeAllCkeckBox.isSelected = true
            
            phoneButtonActivate()
            iPinButtonActivate()
        }else{
            agreeAllCkeckBox.isSelected = false
            
            buttonInactivate(phoneNextButton)
            buttonInactivate(iPinNextButton)
        }
    }
    
    
    
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
    
    
    func phoneButtonActivate(){
        phoneNextButton.backgroundColor = .blue
        phoneNextButton.setTitleColor(.white, for: .normal)
    }
    func iPinButtonActivate(){
        iPinNextButton.backgroundColor = .systemGray6
        iPinNextButton.setTitleColor(.systemGray, for: .normal)
    }
    func buttonInactivate(_ button : UIButton){
        button.backgroundColor = .systemGray
        button.setTitleColor(.black, for: .normal)
    }
    
    private lazy var phoneNextButton: UIButton = {
        let button = UIButton()
        button.setTitle("휴대폰 인증하고 시작하기", for: .normal)
        buttonInactivate(button)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var iPinNextButton: UIButton = {
        let button = UIButton()
        button.setTitle("아이핀 인증하고 시작하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Property
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "약관동의"
        view.backgroundColor = .systemBackground
        
        
        addSubviews()
        configureConstraints()
        addTargets()
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
        
        containerView.addSubview(phoneNextButton)
        containerView.addSubview(iPinNextButton)
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
        phoneNextButton.snp.makeConstraints { make in
            make.top.equalTo(ageLabelBackgroundView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(47)
        }
        iPinNextButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNextButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(47)
            make.bottom.equalToSuperview() // 이것이 중요함
        }
    }
    
    private func addTargets() {
        
    }

}



class UICheckBox1: UIButton {
    private let disposeBag = DisposeBag()
    private var offimage: UIImage?
    private var onimage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setTitle(title : String) {
        self.setTitle("  " + title, for: .normal)
    }
    func setFont(size : CGFloat, weight : UIFont.Weight = .regular) {
        self.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.offimage = offimage?.resize(newWidth: size*0.8, newHeight: size*0.8)
        self.onimage = onimage?.resize(newWidth: size*0.8, newHeight: size*0.8)
        self.setImage(offimage, for: .normal)
        self.setImage(onimage, for: .selected)
    }
    func setWeight(weight : UIFont.Weight) {
        self.titleLabel?.font = UIFont.systemFont(ofSize: self.titleLabel?.font.pointSize ?? 15, weight: weight)
    }
    func setSelectedColor(color : UIColor) {
        self.onimage = self.onimage?.withTintColor(color)
        self.setImage(onimage, for: .selected)
        self.setTitleColor(color, for: .selected)
    }
    func setNormalColor(color : UIColor) {
        self.offimage = self.offimage?.withTintColor(color)
        self.setImage(offimage, for: .normal)
        self.setTitleColor(color, for: .normal)
    }
    private func setup() {
        self.offimage = UIImage(systemName: "checkmark")?
            .resize(newWidth: 12, newHeight: 12)
            .withTintColor(.lightGray)
        self.onimage = UIImage(systemName: "checkmark")?
            .resize(newWidth: 12, newHeight: 12)
            .withTintColor(.black)
        
        self.setTitle("  ", for: .normal)
        self.setTitleColor(.lightGray, for: .normal)
        self.setTitleColor(.black, for: .selected)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        self.setImage(offimage, for: .normal)
        self.setImage(onimage, for: .selected)
        
        self.rx.tap.subscribe(onNext: {
            self.isSelected = !self.isSelected
            guard let _ = self.buttonClicked else { return }
            self.buttonClicked!()
        })
        .disposed(by: disposeBag)
//        self.addTarget(self, action: #selector(changeStateofCheckBox(_:)), for: .touchUpInside)
    }
    private var buttonClicked : (() -> Void)?
    func setEventFunction(function : (() -> Void)?){
        buttonClicked = function
    }
}

