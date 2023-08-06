//
//  CertificatedUniversity.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

/// 학교 선택하는 화면
final class ChooseUniversityViewController: UIViewController {
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "학교 선택", style: .done, target: self, action: nil)
        btn.isEnabled = false
        btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .disabled)
        return btn
    }()
    
    
    /// MARK: 프로그레스 바
    private lazy var progressBar: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.backgroundColor = UIColor(hexCode: "D1D1D1")
        pv.progress = 0.3
        return pv
    }()
    
    /// MARK: 입학년도 제목
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.text = "입학년도"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    /// MARK: 연도 버튼
    private lazy var yearButton: SelectedButton = {
        let btn = SelectedButton()
        btn.initText(text: "연도 선택(학번)")
        btn.backgroundColor = .clear
        return btn
    }()
    
    /// MARK: 학교 선택 제목
    private lazy var universityLabel: UILabel = {
        let label = UILabel()
        label.text = "학교"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    /// MARK: 학교 선택 버튼
    private lazy var universityButton: SelectedButton = {
        let btn = SelectedButton()
        btn.initText(text: "학교 이름 검색")
        btn.backgroundColor = .clear
        return btn
    }()
    
    /// MARK: 다음 화면 넘어가는 버튼
    private lazy var nextButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("다음", for: .normal)
        btn.backgroundColor = UIColor(hexCode: "F5F5F5")
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = ChooseUniversityViewModel()
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .white
        
        addSubviews()
        clickedButtons()
        bind()
    }
    
    
    
    /// MARK: Add UI
    private func addSubviews() {
        view.addSubview(progressBar)
        view.addSubview(yearLabel)
        view.addSubview(yearButton)
        view.addSubview(universityLabel)
        view.addSubview(universityButton)
        
        view.addSubview(nextButton)
        configureConstraints()
    }
    
    /// MARK: set AutoLayout
    private func configureConstraints() {
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        yearButton.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        universityLabel.snp.makeConstraints { make in
            make.top.equalTo(yearButton.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        universityButton.snp.makeConstraints { make in
            make.top.equalTo(universityLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(universityButton.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/20)
        }
    }
    
    /// MARK: binding viewModel
    private func bind(){
        viewModel.observeSelectedForChangeColor()
            .bind { [weak self] check in
                if check{
                    self?.nextButton.backgroundColor = .systemBlue
                    self?.nextButton.setTitleColor(.white, for: .normal)
                }
                else{
                    self?.nextButton.backgroundColor = UIColor(hexCode: "F5F5F5")
                    self?.nextButton.setTitleColor(.black, for: .normal)
                }
            }
            .disposed(by: disposeBag)
    }
    
    /// MARK: 버튼 클릭 했을 때
    private func clickedButtons(){
        yearButton.rx.tap
            .bind{ [weak self] in
                let pickerViewController = PickerViewController(pickerValues: SelectUniversity.years)
                pickerViewController.modalPresentationStyle = .overCurrentContext
                pickerViewController.delegate = self
                self?.present(pickerViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        universityButton.rx.tap
            .bind { [weak self] in
                /// 대학 선택 버튼
                let searchUniversityViewController = SearchUniversityViewController()
                searchUniversityViewController.modalPresentationStyle = .formSheet
                searchUniversityViewController.selctedUniversity
                    .bind { university in
                        self?.universityButton.inputData(text: university)
                        self?.viewModel.universityRelay.accept(university)
                    }
                    .disposed(by: self?.disposeBag ?? DisposeBag())
                self?.present(searchUniversityViewController,animated: true)
            }
            .disposed(by: disposeBag)
     
        nextButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.checkSelected()
                    .subscribe(onNext: { check in
                        if check{
                            let certificatedEmailViewController = CertificatedEmailViewController()
                            self?.navigationItem.backButtonTitle = " "
                            self?.navigationController?.pushViewController(certificatedEmailViewController, animated: true)
                            
                            SignUpDataViewModel.viewModel.yearRelay.accept(self?.viewModel.yearRelay.value ?? "")
                            SignUpDataViewModel.viewModel.universityRelay.accept(self?.viewModel.universityRelay.value ?? "")
                        }
                        else{
                            self?.showAlert(text: "모두 선택해주세요!")
                        }
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
            }
            .disposed(by: disposeBag)
    }
    
    /// MARK:  다 선택이 안된 경우 실행
    private func showAlert(text: String){
        let sheet = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default)
        
        sheet.addAction(success)
        self.present(sheet,animated: true)
    }
}

extension ChooseUniversityViewController: SendDataDelegate{
    func sendData(tag: Int, data: String) {
        yearButton.inputData(text: data)
        viewModel.yearRelay.accept(data)
    }
}
