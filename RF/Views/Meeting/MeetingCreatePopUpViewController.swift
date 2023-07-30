//
//  MeetingCreatePopUpViewController.swift
//  RF
//
//  Created by 정호진 on 2023/07/30.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

final class MeetingCreatePopUpViewController: DimmedViewController{
    
    /// MARK: 배경 뷰
    private lazy var baseUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    /// MARK: 추가 정보 이미지 버튼
    private lazy var infoButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "exclamationmark.circle")?.resize(newWidth: 20), for: .normal)
        return btn
    }()
    
    /// MARK: 추가 정보 보이는 뷰
    private lazy var infoUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    /// MARK: 추가 정보 글귀
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = MeetingCreatePopUp.information
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 2
        return label
    }()
    
    /// MARK: 안내 문구
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = MeetingCreatePopUp.description
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    /// MARK: 확인 버튼
    private lazy var checkButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(MeetingCreatePopUp.check, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = UIColor(hexCode: "D9D9D9")
        btn.titleLabel?.font = .systemFont(ofSize: 17)
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    var checkingConformButton: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    // MARK: - init
    
    init(){
        super.init(durationTime: 0.3, alpha: 0.25)
        addSubviews()
        clickedButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    /// Add UI
    private func addSubviews(){
        view.addSubview(baseUIView)
        baseUIView.addSubview(descriptionLabel)
        baseUIView.addSubview(checkButton)
        baseUIView.addSubview(infoButton)
        view.addSubview(infoUIView)
        infoUIView.addSubview(infoLabel)
        
        configureCollectionView()
    }
    
    /// Set AutoLayout
    private func configureCollectionView() {
        baseUIView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/4)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }
        
        infoButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        infoUIView.snp.makeConstraints { make in
            make.bottom.equalTo(infoButton.snp.centerY)
            make.trailing.equalTo(infoButton.snp.centerX)
            make.height.equalTo(baseUIView.snp.height).multipliedBy(0.1/0.5)
            make.width.equalTo(baseUIView.snp.width).multipliedBy(0.2/0.3)
        }
        
        checkButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.safeAreaLayoutGuide.layoutFrame.width/4)
        }
    }
    
    /// MARK: 버튼들 클릭 하는 경우
    private func clickedButtons(){
        checkButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true){
                    self?.checkingConformButton.onNext(true)
                }
            }
            .disposed(by: disposeBag)
        
        infoButton.rx.tap
            .bind { [weak self] in
               print("clikced infoButton")
                self?.infoUIView.isHidden = false
                
            }
            .disposed(by: disposeBag)
    }
    
}
