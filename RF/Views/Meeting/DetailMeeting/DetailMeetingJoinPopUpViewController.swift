//
//  DetailMeetingJoinPopUpViewController.swift
//  RF
//
//  Created by 정호진 on 2023/07/30.
//

import Foundation
import SnapKit
import RxSwift
import UIKit

final class DetailMeetingJoinPopUpViewController: DimmedViewController{
    
    /// MARK: Popup view 배경
    private lazy var baseUIView: UIView = {
        let view = UIView()
        view.backgroundColor = BackgroundColor.white.color
        return view
    }()
     
    /// MARK: 모임 가입 여부에 대한 설명
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = DetailMeetingJoinPopUp.description
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    /// MARK: 확인 버튼
    private lazy var checkButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(DetailMeetingJoinPopUp.check, for: .normal)
        btn.backgroundColor = UIColor(hexCode: "D9D9D9")
        btn.titleLabel?.font = .systemFont(ofSize: 18)
        btn.layer.cornerRadius = 15
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - init
    
    init() {
        super.init(durationTime: 0.3, alpha: 0.25)
        addSubviews()
        clickedBtns()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Functions
    
    /// Add UI
    private func addSubviews(){
        view.addSubview(baseUIView)
        baseUIView.addSubview(descriptionLabel)
        baseUIView.addSubview(checkButton)
        
        configureCollectionView()
    }
    
    /// Set AutoLayout
    private func configureCollectionView() {
        baseUIView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/4)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(view.safeAreaLayoutGuide.layoutFrame.width/3)
        }
    }
    
    /// MARK: 버튼 클릭 함수
    private func clickedBtns(){
        checkButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
