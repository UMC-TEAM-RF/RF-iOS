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
        view.layer.cornerRadius = 20
        return view
    }()

    /// MARK: 추가 정보 보이는 뷰
    private lazy var lineUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "C2C2C3")
        return view
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
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.backgroundColor = .clear
        btn.titleLabel?.font = .systemFont(ofSize: 17)
        return btn
    }()

    private let disposeBag = DisposeBag()
    
    ///   팝업 뷰에서 확인 버튼을 눌렀는지 확인
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
        baseUIView.addSubview(lineUIView)

        configureCollectionView()
    }

    /// Set AutoLayout
    private func configureCollectionView() {
        baseUIView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/6)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }

        lineUIView.snp.makeConstraints { make in
            make.bottom.equalTo(checkButton.snp.top).offset(-10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        checkButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
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

    }

}
