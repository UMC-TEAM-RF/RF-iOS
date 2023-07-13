//
//  TermsConditionsView.swift
//  RF
//
//  Created by 용용이 on 2023/07/12.
//

import UIKit
import SnapKit
/*
final class TermsConditionsViewController: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    private lazy var view1: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    private lazy var view2: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    private lazy var view3: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
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
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "약관동의"
        view.backgroundColor = .systemBackground
        
//        navigationController?.navigationBar.isHidden = true
        
        
        
        self.view.addSubview(scrollView) // 메인뷰에
        scrollView.addSubview(contentView)
        
//        _ = [view1, view2, view3].map { self.contentView.addSubview($0)}
        self.contentView.addSubview(view1)
        self.contentView.addSubview(view2)
        self.contentView.addSubview(view3)
        self.contentView.addSubview(agreeAllCkeckBox)
        
        
        
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview() // 스크롤뷰가 표현될 영역
        }
        
        
        contentView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.top.bottom.equalToSuperview()
        }
        
        agreeAllCkeckBox.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        view1.snp.makeConstraints { (make) in
            
            make.top.equalTo(agreeAllCkeckBox.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        view2.snp.makeConstraints { (make) in
            
            make.top.equalTo(view1.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        view3.snp.makeConstraints { (make) in
            
            make.top.equalTo(view2.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
            make.bottom.equalToSuperview() // 이것이 중요함
        }
        
//        addSubviews()
//        configureConstraints()
//        addTargets()
    }
}*/



final class TermsConditionsViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
//        view.isUserInteractionEnabled = true
        return view
    }()
    
    // 네비게이션 바
    private lazy var navigationContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var navigationLogo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "rf_logo")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var navigationSearchButton: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "bell")
        view.contentMode = .scaleAspectFill
        view.tintColor = .black
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
            
        }
    }
    private lazy var agreeAllUnderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    
    private func updateStateofAll(){
        if(agreeServiceCkeckBox.isSelected){
            agreeAllCkeckBox.isSelected = true
        }else{
            agreeAllCkeckBox.isSelected = false
        }
    }
    
    
    
    private lazy var agreeServiceCkeckBox: UIButton = {
        let button = UIButton()
        let offimage = UIImage(systemName: "checkmark")?
            .resize(newWidth: 12, newHeight: 12)
            .withTintColor(.lightGray)
        let onimage = UIImage(systemName: "checkmark")?
            .resize(newWidth: 12, newHeight: 12)
            .withTintColor(.black)
        
        button.setTitle("  " + "서비스이용약관 동의 (필수)", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        button.setImage(offimage, for: .normal)
        button.setImage(onimage, for: .selected)
        
        button.addTarget(self, action: #selector(changeStateofCheckBox(_:)), for: .touchUpInside)
        return button
    }()
    @objc private func changeStateofCheckBox(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        updateStateofAll()
    }
    

    // MARK: - Property
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = "약관동의"
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.isHidden = true
        
        
        addSubviews()
        configureConstraints()
        addTargets()
    }
    
    // MARK: - addSubviews
    
    private func addSubviews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        // 컨테이너 뷰
        containerView.addSubview(navigationContainerView)
        
        
        
        // 네비게이션 바
        navigationContainerView.addSubview(navigationLogo)
        navigationContainerView.addSubview(navigationSearchButton)
        navigationContainerView.addSubview(agreeAllCkeckBox)
//        containerView.addSubview(agreeAllCkeckBox)
        containerView.addSubview(agreeAllUnderlineView)
//        containerView.addSubview(agreeServiceCkeckBox)
        
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
        
        
        
        // 네비게이션 바
        navigationContainerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            //make.width.equalToSuperview()
            make.height.equalTo(60)
        }
        navigationLogo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(12)
        }
        navigationSearchButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(18)
        }
        
        agreeAllCkeckBox.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(navigationLogo.snp.right).offset(20)
            make.right.equalTo(navigationSearchButton.snp.left).offset(-20)
        }
        
        
        
        agreeAllUnderlineView.snp.makeConstraints { make in
            make.top.equalTo(navigationContainerView.snp.bottom).offset(40)
            make.left.right.equalToSuperview()
            make.height.equalTo(1200)
            make.bottom.equalToSuperview() // 이것이 중요함
        }

//
//        agreeServiceCkeckBox.snp.makeConstraints { make in
//            make.top.equalTo(agreeAllUnderlineView.snp.bottom).offset(20)
//            make.left.equalToSuperview().inset(20)
//        }
    }
    
    private func addTargets() {
//        onboardingButton.addTarget(self, action: #selector(onboardingButtonTapped), for: .touchUpInside)
//        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
//        SignUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }

}

