//
//  UserInfoViewController.swift
//  RF
//
//  Created by 나예은 on 2023/07/10.
//07-1

import UIKit
import SnapKit
import RxSwift

/// 출생국가, 관심 나라, 관심 언어 선택하는 화면
final class UserInfoViewController: UIViewController {
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "기본 설정", style: .done, target: self, action: nil)
        btn.isEnabled = false
        btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: TextColor.first.color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)], for: .disabled)
        return btn
    }()
    
    /// MARK:  기본정보
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    /// MARK:  출생 국가 제목
    private lazy var userNationLabel: UILabel = {
        let label = UILabel()
        label.text = "출생 국가"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 출생 국가 선택하는 버튼
    private lazy var nationButton: UIButton = {
        let button = UIButton()
        button.setTitle("  " + "국가를 선택해주세요", for: .normal)
        button.setTitleColor(TextColor.secondary.color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor = ButtonColor.normal.color
        button.layer.cornerRadius = 5
        button.contentHorizontalAlignment = .left
        return button
    }()

    /// MARK: 관심 나라 제목
    private lazy var favNationLabel: UILabel = {
        let label = UILabel()
        label.text = "관심 나라"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 관심 나라 선택하는 버튼
    private lazy var favNationButton: UIButton = {
        let button = UIButton()
        button.setTitle("  관심있는 나라를 선택해주세요", for: .normal)
        button.setTitleColor(TextColor.secondary.color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor =  BackgroundColor.white.color
        button.layer.cornerRadius = 5
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    /// MARK: 관심 언어 제목
    private lazy var favLanguageLabel: UILabel = {
        let label = UILabel()
        label.text = "관심 언어"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 관심 언어 선택하는 버튼
    private lazy var favLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle("  관심있는 언어를 선택해주세요", for: .normal)
        button.setTitleColor(TextColor.secondary.color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor =  BackgroundColor.white.color
        button.layer.cornerRadius = 5
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    /// MARK: 소속 학과 제목
    private lazy var majorLabel: UILabel = {
        let label = UILabel()
        label.text = "소속 학과"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 소속 학과 선택하는 버튼
    private lazy var majorButton: UIButton = {
        let button = UIButton()
        button.setTitle("  소속된 단과대를 선택해주세요", for: .normal)
        button.setTitleColor(TextColor.secondary.color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor =  BackgroundColor.white.color
        button.layer.cornerRadius = 5
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    /// MARK: Next Button
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor =  BackgroundColor.white.color
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = UserInfoViewModel()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = TextColor.first.color
        view.backgroundColor = .white
        
        addSubviews()
        clickedButtons()
        observeSelected()
    }
    
    /// MARK: Add UI
    private func addSubviews() {
        view.addSubview(topLabel)
        view.addSubview(userNationLabel)
        view.addSubview(favNationLabel)
        view.addSubview(favLanguageLabel)
        view.addSubview(nextButton)
        view.addSubview(nationButton)
        view.addSubview(favNationButton)
        view.addSubview(favLanguageButton)
        view.addSubview(majorLabel)
        view.addSubview(majorButton)
        
        configureConstraints()
    }
    
    /// MARK: Set AutoLayout
    private func configureConstraints() {
        
        //알프닝의 기본 정보를 설정해주세요.
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        //출생 국가
        userNationLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        //국가 설정 메뉴 버튼
        nationButton.snp.makeConstraints { make in
            make.top.equalTo(userNationLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(47)
        }
        
        //관심 나라
        favNationLabel.snp.makeConstraints { make in
            make.top.equalTo(nationButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        //관심 나라 설정 메뉴 버튼
        favNationButton.snp.makeConstraints { make in
            make.top.equalTo(favNationLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(47)
        }
        
        //관심 언어
        favLanguageLabel.snp.makeConstraints { make in
            make.top.equalTo(favNationButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        //관심 언어 설정 메뉴 버튼
        favLanguageButton.snp.makeConstraints { make in
            make.top.equalTo(favLanguageLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(47)
        }
        
        // 소속 학과
        majorLabel.snp.makeConstraints { make in
            make.top.equalTo(favLanguageButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // 소속 학과 설정 메뉴 버튼
        majorButton.snp.makeConstraints { make in
            make.top.equalTo(majorLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(47)
        }
        
        
        //다음
        nextButton.snp.makeConstraints { make in
            make.leading.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/18)
        }
    }
    
    /// MARK: 버튼 클릭 했을 때
    private func clickedButtons(){
        
        nationButton.rx.tap
            .bind { [weak self] in
                let choiceBornCountryView = ChoiceBornCountryView()
                choiceBornCountryView.modalPresentationStyle = .formSheet
                choiceBornCountryView.selctedCountry
                    .bind { country in
                        self?.viewModel.bornCountry.accept(country.key ?? "")
                        self?.nationButton.setTitle("  \(country.value ?? "")", for: .normal)
                    }
                    .disposed(by: self?.disposeBag ?? DisposeBag())
                self?.present(choiceBornCountryView, animated: true)
            }
            .disposed(by: disposeBag )
        
        favNationButton.rx.tap
            .bind { [weak self] in
                let choiceInterestingCountryView = ChoiceInterestingCountryView()
                choiceInterestingCountryView.modalPresentationStyle = .formSheet
                choiceInterestingCountryView.selctedCountry
                    .bind { country in
                        self?.viewModel.interestingCountry.accept(country)
                        let selectedList = country.map { "\($0.value ?? "")" }.joined(separator: ", ")
                        self?.favNationButton.setTitle(selectedList, for: .normal)
                    }
                    .disposed(by: self?.disposeBag ?? DisposeBag())
                self?.present(choiceInterestingCountryView, animated: true)
            }
            .disposed(by: disposeBag)
        
        favLanguageButton.rx.tap
            .bind { [weak self] in
                let choiceInterestingLanguageView = ChoiceInterestingLanguageView()
                choiceInterestingLanguageView.modalPresentationStyle = .formSheet
                choiceInterestingLanguageView.selctedLanguage
                    .bind { language in
                        self?.viewModel.interestingLanguage.accept(language)
                        let selectedList = language.map { "\($0.value ?? "")" }.joined(separator: ", ")
                        self?.favLanguageButton.setTitle(selectedList, for: .normal)
                    }
                    .disposed(by: self?.disposeBag ?? DisposeBag())
                self?.present(choiceInterestingLanguageView, animated: true)
            }
            .disposed(by: disposeBag)
        
        majorButton.rx.tap
            .bind { [weak self] in
                guard let self = self else {return}
                let choiceMajorView = ChoiceMajorView()
                choiceMajorView.modalPresentationStyle = .formSheet
                choiceMajorView.selctedMajor
                    .bind { [weak self] major in
                        guard let self = self else {return}
                        viewModel.major.accept(major.key ?? "")
                        majorButton.setTitle("  \(major.value ?? "")", for: .normal)
                    }
                    .disposed(by: disposeBag)
                present(choiceMajorView, animated: true)
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind { [weak self] in
                self?.selectedAll()
            }
            .disposed(by: disposeBag)
        
    }
    
    /// MARK: check Selected All
    private func selectedAll(){
        viewModel.checkSelectedAll()
            .subscribe(onNext: { [weak self] check in
                if check{
                    let personalInterestsViewController = PersonalInterestsViewController()
                    self?.navigationItem.backButtonTitle = " "
                    self?.navigationController?.pushViewController(personalInterestsViewController, animated: true)
                    
                    SignUpDataViewModel.viewModel.bornCountry.accept(self?.viewModel.bornCountry.value ?? "")
                    SignUpDataViewModel.viewModel.interestingCountry.accept(self?.viewModel.interestingCountry.value ?? [])
                    SignUpDataViewModel.viewModel.interestingLanguage.accept(self?.viewModel.interestingLanguage.value ?? [])
                    SignUpDataViewModel.viewModel.major.accept(self?.viewModel.major.value ?? "")
                }
            })
            .disposed(by: disposeBag)
    }
    
    /// MARK: 모두 선택했을 때 버튼 색깔 바뀌게 하는 함수
    private func observeSelected(){
        viewModel.checkSelectedAll()
            .bind { [weak self] check in
                if check{
                    self?.nextButton.backgroundColor = ButtonColor.main.color
                    self?.nextButton.setTitleColor(ButtonColor.normal.color, for: .normal)
                }
                else{
                    self?.nextButton.backgroundColor = ButtonColor.normal.color
                    self?.nextButton.setTitleColor(TextColor.first.color, for: .normal)
                }
            }
            .disposed(by: disposeBag)
    }
}
