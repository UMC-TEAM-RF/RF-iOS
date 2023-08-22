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
import Mantis

final class SetDescriptViewController: UIViewController {
    
    // MARK: - UI Property
    
    // 프로그레스 바
    private lazy var progressBar: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.backgroundColor = BackgroundColor.dark.color
        pv.progress = 0.75
        return pv
    }()
    
    // 배너 라벨
    private lazy var bannerLabel: UILabel = {
        let label = UILabel()
        label.text = "배너를 설정해 주세요."
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = TextColor.first.color
        return label
    }()
    
    private lazy var bannerBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ButtonColor.normal.color
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var cameraImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "camera.fill")
        iv.tintColor = TextColor.secondary.color
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        return iv
    }()
    
    // 메인 라벨
    private lazy var descriptLabel: UILabel = {
        let label = UILabel()
        label.text = "모임을 간단하게 소개해 주세요."
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = TextColor.first.color
        return label
    }()
    
    private lazy var descriptTextView: UITextView = {
        let tv = UITextView()
        tv.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        tv.backgroundColor = ButtonColor.normal.color
        tv.text = textViewPlaceholder
        tv.textColor = .lightGray
        tv.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        tv.layer.cornerRadius = 10
        tv.delegate = self
        viewModel.meetingDescriptionColor.accept("gray")
        return tv
    }()
    
    // 다음 버튼
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = ButtonColor.normal.color
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Property
    
    private let textViewPlaceholder = "최소 30자 이상 작성"
    private let viewModel = SetDescriptViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        updateTitleView(title: "모임 생성")
        setupCustomBackButton()
        
        addSubviews()
        configureConstraints()
        addTargets()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(progressBar)
        view.addSubview(bannerLabel)
        view.addSubview(bannerBackgroundView)
        
        bannerBackgroundView.addSubview(cameraImageView)
        bannerBackgroundView.addSubview(imageView)
        
        view.addSubview(descriptLabel)
        view.addSubview(descriptTextView)
        view.addSubview(nextButton)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        // 프로그레스 바
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
        
        // 배너 설정 라벨
        bannerLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(30)
        }
        
        // 배너 설정 이미지 뷰
        bannerBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(bannerLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(bannerBackgroundView.snp.width).multipliedBy(0.9/1.6)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 모임 소개 라벨
        descriptLabel.snp.makeConstraints { make in
            make.top.equalTo(bannerBackgroundView.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(30)
        }
        
        descriptTextView.snp.makeConstraints { make in
            make.top.equalTo(descriptLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(150)
        }
        
        // 다음
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - addTargets()
    
    private func addTargets() {
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped)))
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                CreateViewModel.viewModel.meetingDescription.accept(self?.viewModel.meetingDescription.value ?? "")
                CreateViewModel.viewModel.meetingImage.accept(self?.viewModel.meetingImage.value)
                self?.navigationController?.pushViewController(SetDetailInfoViewController(), animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    /// MARK:
    private func bind() {
        descriptTextView.rx.text
            .bind(onNext: { [weak self] text in
                if let text = text {
                    self?.viewModel.meetingDescription.accept(text)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.isValid()
            .subscribe(onNext: { [weak self] isValid in
                self?.nextButton.backgroundColor = isValid ? ButtonColor.main.color : ButtonColor.normal.color
                self?.nextButton.setTitleColor(isValid ? ButtonColor.normal.color : TextColor.first.color, for: .normal)
                self?.nextButton.isEnabled = isValid
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

// MARK: - Ext: TextViewDelegate

extension SetDescriptViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholder {
            textView.text = nil
            textView.textColor = TextColor.first.color
        }
        viewModel.meetingDescriptionColor.accept("black")
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = textViewPlaceholder
            textView.textColor = TextColor.secondary.color
        }
        
    }
}

// MARK: - Ext: ImagePickerDelegate

extension SetDescriptViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // 이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    // 이미지 피커에서 이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            dismiss(animated: true) {
                self.openCropVC(image: image)
            }
        }
        picker.dismiss(animated: false)
    }
    
}

// MARK: - Ext: CropViewControllerDelegate

extension SetDescriptViewController: CropViewControllerDelegate{
    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation, cropInfo: CropInfo) {
        
        imageView.image = cropped
        viewModel.meetingImage.accept(cropped)
        cropViewController.dismiss(animated: true)
    }
    
    func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
        cropViewController.dismiss(animated: true)
    }
    
    private func openCropVC(image: UIImage) {
        
        let cropViewController = Mantis.cropViewController(image: image)
        cropViewController.delegate = self
        cropViewController.modalPresentationStyle = .fullScreen
        cropViewController.config.presetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 16/9)

        self.present(cropViewController, animated: true)
    }
}


