//
//  SetDetailInfoViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/11.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SetDetailInfoViewController: UIViewController {
    
    // MARK: - UI Property
    
    // 네비게이션 바
    private lazy var navigationBar: CreateMeetingNavigationBar = {
        let view = CreateMeetingNavigationBar()
        view.delegate = self
        return view
    }()
    
    // 프로그레스 바
    private lazy var progressBar: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.backgroundColor = UIColor(hexCode: "D1D1D1")
        pv.progress = 1
        return pv
    }()
    
    // 메인 라벨
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "모임의 세부 정보를 입력해 주세요."
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    // 다음 버튼
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("모임 생성하기", for: .normal)
        button.backgroundColor = .tintColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        addSubviews()
        configureConstraints()
        addTargets()
    }
    
    // MARK: - addSubviews
    
    private func addSubviews() {
        view.addSubview(navigationBar)
        view.addSubview(progressBar)
        view.addSubview(mainLabel)
        view.addSubview(createButton)
    }
    
    // MARK: - configureConstraints
    
    private func configureConstraints() {
        // 네비게이션 바
        navigationBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        // 프로그레스 바
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
        
        // 메인 라벨
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        // 다음
        createButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - addTargets
    
    private func addTargets() {
        createButton.rx.tap
            .subscribe(onNext: {
                self.tabBarController?.tabBar.isHidden = false
                self.navigationController?.popToRootViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension SetDetailInfoViewController: NavigationBarDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
