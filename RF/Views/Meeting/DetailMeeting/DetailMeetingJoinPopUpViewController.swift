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
import RxRelay

final class DetailMeetingJoinPopUpViewController: DimmedViewController{
    
    /// MARK: Popup view 배경
    private lazy var baseUIView: UIView = {
        let view = UIView()
        view.backgroundColor = BackgroundColor.white.color
        view.layer.cornerRadius = 20
        return view
    }()
     
    /// MARK: 모임 가입 여부에 대한 설명
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = DetailMeetingJoinPopUp.description
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    /// MARK: 추가 정보 보이는 뷰
    private lazy var lineUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "C2C2C3")
        return view
    }()
    
    /// MARK: 확인 버튼
    private lazy var checkButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(DetailMeetingJoinPopUp.check, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18)
        btn.layer.cornerRadius = 15
        btn.setTitleColor(.systemBlue, for: .normal)
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = DetailMeetingJoinPopUpViewModel()
    var meetingIdRelay: BehaviorRelay<Int?> = BehaviorRelay(value: nil)
    var clicekdButtonSubject: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
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
        baseUIView.addSubview(lineUIView)
        
        configureCollectionView()
    }
    
    /// Set AutoLayout
    private func configureCollectionView() {
        baseUIView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/7)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-25)
            make.centerX.equalToSuperview()
        }
        
        lineUIView.snp.makeConstraints { make in
            make.bottom.equalTo(checkButton.snp.top).offset(-10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        checkButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    /// MARK: 버튼 클릭 함수
    private func clickedBtns(){
        viewModel.meetingIdRelay.accept(meetingIdRelay.value)
        
        checkButton.rx.tap
            .bind { [weak self] in
                
                self?.viewModel.sendingJoin()
                    .subscribe(
                        onNext: { check in
                            self?.dismiss(animated: true)
                            self?.clicekdButtonSubject.onNext(true)
                        },
                        onError: { error in
                            print("모임 가입 신청하기 오류!!!\n\(error)")
                        })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
            }
            .disposed(by: disposeBag)
    }
    
}
