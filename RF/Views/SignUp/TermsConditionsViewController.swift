//
//  TermsConditionsView.swift
//  RF
//
//  Created by 용용이 on 2023/07/12.
//

import UIKit
import SnapKit


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
        containerView.addSubview(agreeAllUnderlineView)
        
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
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        navigationLogo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(12)
        }
        navigationSearchButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(18)
        }
        
        agreeAllCkeckBox.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(navigationLogo.snp.trailing).offset(20)
            make.trailing.equalTo(navigationSearchButton.snp.leading).offset(-20)
        }
        
        
        
        agreeAllUnderlineView.snp.makeConstraints { make in
            make.top.equalTo(navigationContainerView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1200)
            make.bottom.equalToSuperview() // 이것이 중요함
        }
    }
    
    private func addTargets() {
        
    }

}

