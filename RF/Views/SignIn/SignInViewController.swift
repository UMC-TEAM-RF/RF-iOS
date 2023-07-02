//
//  ViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/02.
//

import UIKit

final class SignInViewController: UIViewController {
    
    // MARK: - UI Property
    
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
        view.addSubview(bottomStackView)
    }

    private func configureConstraints() {
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

