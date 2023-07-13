//
//  SetDescriptViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/11.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

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
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
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
    
    private let textViewPlaceholder = "모임에 대해 소개해 주세요!"
    private let disposeBag = DisposeBag()
    
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
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped)))
        
        nextButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(SetDetailInfoViewController(), animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    @objc func imageViewTapped() {
        // 이미지 피커 컨트롤러 생성
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary // 이미지 소스로 사진 라이브러리 선택
        picker.allowsEditing = false// 이미지 편집 기능 On
        
        // 델리게이트 지정
        picker.delegate = self
        
        // 이미지 피커 컨트롤러 실행
        self.present(picker, animated: true)
    }
    
}

// MARK: - TextViewDelegate

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

// MARK: - UIImagePickerControllerDelegate

extension SetDescriptViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // 이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 이미지 피커 컨트롤러 창 닫기
        self.dismiss(animated: true)
    }
    
    // 이미지 피커에서 이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("이미지 선택")
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: true) {
            // 이미지를 이미지 뷰에 표시
            let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            self.imageView.image = img
        }
    }
    
    
}

// MARK: - NavigationBarDelegate

extension SetDescriptViewController: NavigationBarDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
