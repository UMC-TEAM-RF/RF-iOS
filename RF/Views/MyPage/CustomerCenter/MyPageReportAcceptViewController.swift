//
//  MyPageReportApplyViewController.swift
//  RF
//
//  Created by 용용이 on 2023/10/10.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class MyPageReportAcceptViewController: UIViewController {
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "알프를 이용하면서 불편했던 점이 있나요 ?"
        label.font = .systemFont(ofSize: 14)
        label.textColor = TextColor.first.color
        return label
    }()
    
    // 접수하기 버튼
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.becomeFirstResponder()
        
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = TextColor.secondary.color.cgColor
        textView.layer.cornerRadius = 10
        //Corner radius 적용을 위한 코드
        textView.clipsToBounds = true
        
        return textView
    }()
    // 접수하기 버튼
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("접수하기", for: .normal)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = UIColor.init(hexCode: "#F5F5F5")
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        configureConstraints()
        configureTextView()
        bind()
    }
    
    
    
    /// MARK: - addsubviews()
    private func addSubviews() {
        view.addSubview(mainLabel)
        view.addSubview(textView)
        view.addSubview(applyButton)
    }

    /// MARK: - configureConstraints()
    private func configureConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        textView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(200)
        }
        applyButton.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(47)
        }
    }
    private func configureTextView(){
        textView.delegate = self
    }
    private func bind(){
        
        applyButton.rx.tap
            .subscribe(onNext: {
                if self.textView.text.isEmpty {return}
                let alertController = UIAlertController(title: "알림", message: "신고가 접수되었습니다.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
                
                alertController.addAction(ok)
                
                self.present(alertController, animated: true)
                
            })
            .disposed(by: disposeBag)
    }
    
    private func textFieldDidChange(_ textView: UITextView) {
        if textView.text.isEmpty{
            self.applyButton.setTitleColor(TextColor.first.color, for: .normal)
            self.applyButton.backgroundColor = ButtonColor.normal.color
        }
        else{
            self.applyButton.setTitleColor(BackgroundColor.white.color, for: .normal)
            self.applyButton.backgroundColor = ButtonColor.main.color
        }
    }
}

// MARK: extension - UITextViewDelegate
extension MyPageReportAcceptViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView){
        textFieldDidChange(textView)
    }
}
