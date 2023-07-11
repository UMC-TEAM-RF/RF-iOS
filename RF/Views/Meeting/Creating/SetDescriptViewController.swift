//
//  SetDescriptViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/11.
//

import UIKit

class SetDescriptViewController: UIViewController {
    
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
        pv.progress = 0.75
        return pv
    }()
    
    // 메인 라벨
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "모임을 간단하게 소개해 주세요."
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private lazy var descriptTextView: UITextView = {
        let tv = UITextView()
        tv.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        tv.backgroundColor = .systemGray6
        tv.text = textViewPlaceholder
        tv.textColor = .lightGray
        tv.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        tv.delegate = self
        return tv
    }()
    
    // MARK: - 모임 이미지
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "no_image")
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var cameraImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "camera.fill")
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .systemGray6
        return iv
    }()
    
    // 다음 버튼
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .tintColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Property
    
    let textViewPlaceholder = "모임에 대해 소개해 주세요!"

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        addSubviews()
        configureConstraints()
        addTargets()
        
        view.layoutIfNeeded()
        cameraImageView.layer.cornerRadius = cameraImageView.frame.width / 2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - addSubviews
    
    private func addSubviews() {
        view.addSubview(navigationBar)
        view.addSubview(progressBar)
        view.addSubview(mainLabel)
        view.addSubview(descriptTextView)
        view.addSubview(imageView)
        view.addSubview(cameraImageView)
        view.addSubview(nextButton)
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
        
        // 텍스트 뷰
        descriptTextView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(35)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.height.equalTo(150)
        }
        
        // 사진
        imageView.snp.makeConstraints { make in
            make.top.equalTo(descriptTextView.snp.bottom).offset(25)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.height.equalTo(imageView.snp.width).multipliedBy(0.5)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.width.height.equalTo(imageView.snp.height).multipliedBy(0.2)
            make.centerX.equalTo(imageView.snp.right).offset(-5)
            make.centerY.equalTo(imageView.snp.bottom).offset(-5)
        }
        
        // 다음
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - addTargets
    
    private func addTargets() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - @objc func
    
    @objc func nextButtonTapped() {
        navigationController?.pushViewController(SetDetailInfoViewController(), animated: true)
    }

}

// MARK: - extension TextViewDelegate

extension SetDescriptViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.trimmingCharacters(in: .whitespaces).isEmpty {
        if textView.text.isEmpty {
            textView.text = textViewPlaceholder
            textView.textColor = .lightGray
        }
    }
    
    //    func textViewDidChange(_ textView: UITextView) {
    //        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
    //            textView.text = textViewPlaceholder
    //            textView.textColor = .lightGray
    //            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
    //        } else {
    //            textView.textColor = .black
    //        }
    //    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if textView.text.count <= 10 || text.isEmpty {  // 10자를 초과하지 않거나, Backspace를 누를 때
//            return true
//        } else {
//            return false
//        }
//    }
    
}

// MARK: - extension NavigationBarDelegate

extension SetDescriptViewController: NavigationBarDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
