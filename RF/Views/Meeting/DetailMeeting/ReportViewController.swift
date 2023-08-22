//
//  ReportViewController.swift
//  RF
//
//  Created by 정호진 on 2023/08/22.
//

import Foundation
import UIKit
import RxSwift
import SnapKit
import RxRelay

final class ReportViewController:  DimmedViewController {
     
    /// MARK: Pop up 창 base view
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = BackgroundColor.white.color
        view.layer.cornerRadius = 30
        return view
    }()
    
    /// MARK: 신고 제목
    private lazy var reportTitle: UILabel = {
        let label = UILabel()
        label.text = "신고하기"
        label.textColor = TextColor.first.color
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    /// MARK: 신고 설명
    private lazy var reportDescription: UILabel = {
        let label = UILabel()
        label.text = "신고사유를 적어주세요!"
        label.textColor = TextColor.first.color
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    /// MARK: 신고 사유 적는 TextView
    private lazy var textView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    /// MARK:
    private lazy var buttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.spacing = 0
        return sv
    }()
    
    /// MARK: 취소버튼
    private lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("취소", for: .normal)
        btn.setTitleColor(TextColor.first.color, for: .normal)
        btn.backgroundColor = .clear
        return btn
    }()

    /// MARK: 신고버튼
    private lazy var reportButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("신고", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.backgroundColor = .clear
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    var meetingId: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    private let viewModel = ReportViewModel()
    
    // MARK: - init
    
    init() {
        super.init(durationTime: 0.3, alpha: 0.25)
        bind()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    /// MARK: Add UI
    private func addSubviews(){
        view.addSubview(baseView)
        baseView.addSubview(reportTitle)
        baseView.addSubview(reportDescription)
        baseView.addSubview(textView)
        
        baseView.addSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(reportButton)
        
        configureConstraints()
    }
    
    /// MARK: Setting AutoLayout
    private func configureConstraints(){
        baseView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(200)
        }
        
        reportTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        reportDescription.snp.makeConstraints { make in
            make.top.equalTo(reportTitle.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
     
            
        textView.snp.makeConstraints { make in
            make.top.equalTo(reportDescription.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
    }
    
    /// MARK: rxswift binding functions
    private func bind(){
        
        viewModel.meetingId.accept(meetingId.value)
        
        textView.rx.text
            .bind { [weak self] text in
                guard let self = self else { return }
                guard  let text = text else { return }
                viewModel.reportText.accept(text)
            }
            .disposed(by: disposeBag)
        
        reportButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                viewModel.reportFuction()
                    .subscribe(
                        onNext: { [weak self] check in
                            if check {
                                self?.showAlert(text: "신고 접수 완료")
                                self?.dismiss(animated: true)
                            }
                            else{
                                self?.showAlert(text: "신고 접수 실패")
                            }
                        },
                        onError: { [weak self] check in
                            self?.showAlert(text: "신고 접수 실패")
                        })
                    .disposed(by: disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
   
    }

    
    /// MARK:  알림 창
    private func showAlert(text: String){
        let sheet = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default)
        
        sheet.addAction(success)
        self.present(sheet,animated: true)
    }
    
}
