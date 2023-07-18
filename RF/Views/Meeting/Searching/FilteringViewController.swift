//
//  FilteringViewController.swift
//  RF
//
//  Created by 정호진 on 2023/07/16.
//


import Foundation
import SnapKit
import UIKit
import RxCocoa
import RxSwift

/// MARK: 모임 찾기 필터링 화면
final class FilteringViewController: UIViewController{
    
    /// MARK: 화면 내리는 버튼, 가장 맨위에 았는 버튼
    private lazy var topBtn: UIButton = {
        let btn = UIButton() 
        btn.backgroundColor = UIColor(hexCode: "F5F5F5")
        btn.setTitle(MeetingFiltering.topButton, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.semanticContentAttribute = .forceRightToLeft
        return btn
    }()
    
    /// MARK: 모집 중인 모임만 보기
    private lazy var lookOnce: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hexCode: "F5F5F5")
        btn.setTitle(MeetingFiltering.lookOnce, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    /// MARK: 모집 연령대 제목
    private lazy var ageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = MeetingFiltering.ageTitle
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    /// MARK: 연령대 선택하는 CollectionView
    private lazy var ageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        return cv
    }()
    
    /// MARK: 모집 인원 제목
    private lazy var joinNumberTitleLabel: UILabel = {
        let label = UILabel()
        label.text = MeetingFiltering.joinNumber
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    /// MARK: 1:1  소모임
    private lazy var firstJoinSelection: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor(hexCode: "F5F5F5")
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle(MeetingFiltering.joinNumberList[0], for: .normal)
        return btn
    }()
    
    /// MARK: 2인 이상 모임
    private lazy var secondJoinSelection: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor(hexCode: "F5F5F5")
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle(MeetingFiltering.joinNumberList[1], for: .normal)
        return btn
    }()
    
    /// MARK: 인원 설정하기
    private lazy var thirdJoinSelection: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        btn.setTitle(MeetingFiltering.joinNumberList[2], for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = UIColor(hexCode: "F5F5F5")
        return btn
    }()
    
    /// MARK: 관심 주제 설정 제목
    private lazy var interestingTopicTitleLabel: UILabel = {
        let label = UILabel()
        label.text = MeetingFiltering.interestingTitle
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    /// MARK: 관심 주제 설정 CollectionView
    private lazy var interestingTopicCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        cv.isMultipleTouchEnabled = true
        return cv
    }()
    
    /// MARK: 필터 초기화 버튼
    private lazy var filterClearBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        btn.setTitle(MeetingFiltering.filterClear, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .clear
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = FilteringViewModel()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        clickedBtns()
        getDataFromViewModel()
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        view.addSubview(topBtn)
        view.addSubview(lookOnce)
        view.addSubview(ageTitleLabel)
        view.addSubview(ageCollectionView)
        view.addSubview(joinNumberTitleLabel)
        view.addSubview(firstJoinSelection)
        view.addSubview(secondJoinSelection)
        view.addSubview(thirdJoinSelection)
        view.addSubview(interestingTopicTitleLabel)
        view.addSubview(interestingTopicCollectionView)
        view.addSubview(filterClearBtn)
        
        ageCollectionView.delegate = self
        ageCollectionView.dataSource = self
        ageCollectionView.register(AgeCollectionViewCell.self, forCellWithReuseIdentifier: AgeCollectionViewCell.identifier)
        
        interestingTopicCollectionView.delegate = self
        interestingTopicCollectionView.dataSource = self
        interestingTopicCollectionView.register(InterestingTopicCollectionViewCell.self, forCellWithReuseIdentifier: InterestingTopicCollectionViewCell.identifier)
        
        configureConstraints()
    }
    
    /// MARK: Setting AutoLayout
    private func configureConstraints(){
        topBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/20)
        }
        
        lookOnce.snp.makeConstraints { make in
            make.top.equalTo(topBtn.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(view.safeAreaLayoutGuide.layoutFrame.width*2/3)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/23)
        }
        
        ageTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(lookOnce.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        ageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(ageTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/28)
        }
        
        joinNumberTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(ageCollectionView.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        firstJoinSelection.snp.makeConstraints { make in
            make.top.equalTo(joinNumberTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/23)
        }
        
        secondJoinSelection.snp.makeConstraints { make in
            make.top.equalTo(joinNumberTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/23)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        thirdJoinSelection.snp.makeConstraints { make in
            make.top.equalTo(firstJoinSelection.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/23)
        }
        
        interestingTopicTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(thirdJoinSelection.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        interestingTopicCollectionView.snp.makeConstraints { make in
            make.top.equalTo(interestingTopicTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/6)
        }
        
        filterClearBtn.snp.makeConstraints { make in
            make.top.equalTo(interestingTopicCollectionView.snp.bottom).offset(30)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            
        }
    }
    
    /// MARK: 버튼들 클릭 했을 때 실행
    private func clickedBtns(){
        topBtn.rx.tap
            .bind(onNext: {
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        lookOnce.rx.tap
            .bind(onNext: {
                self.viewModel.checkOnceLook()
            })
            .disposed(by: disposeBag)
        
        firstJoinSelection.rx.tap
            .bind(onNext: {
                self.viewModel.clickJoinFirstButton()
            })
            .disposed(by: disposeBag)
        
        secondJoinSelection.rx.tap
            .bind(onNext: {
                self.viewModel.clickJoinSecondButton()
            })
            .disposed(by: disposeBag)
        
        thirdJoinSelection.rx.tap
            .bind(onNext: {
                self.viewModel.clickJoinThirdButton()
            })
            .disposed(by: disposeBag)
        
        filterClearBtn.rx.tap
            .bind(onNext: {
                self.viewModel.clickResetBtn()
            })
            .disposed(by: disposeBag)
      
    }
    
    /// MARK: ViewModel에서 데이터를 받아오는 함수
    private func getDataFromViewModel(){
        viewModel.ageRelay
            .subscribe(onNext: { [weak self] item in
                self?.updateAgeItem(item)
            })
            .disposed(by: disposeBag)
        
        // 선택된 관심 주제 가져옴
        viewModel.interestingTopicRelay
            .subscribe(onNext: { [weak self] Items in
                self?.updateInterestingTopicItems(Items)
            })
            .disposed(by: disposeBag)
        
        viewModel.checkOnceLookRelay
            .bind(onNext: { [weak self] check in
                self?.updateCheckOnceLook(check)
            })
            .disposed(by: disposeBag)
        
        viewModel.joinFirstButtonRelay
            .bind(onNext: { [weak self] check in
                print("first: \(check)")
                self?.updateJoinFirstBtn(check)
            })
            .disposed(by: disposeBag)
        
        viewModel.joinSecondButtonRelay
            .bind(onNext: { [weak self] check in
                print("second: \(check)")
                self?.updateJoinSecondBtn(check)
            })
            .disposed(by: disposeBag)
        
        viewModel.joinThirdButtonRelay
            .bind(onNext: { [weak self] check in
                print("third: \(check)")
                self?.updateJoinThirdBtn(check)
            })
            .disposed(by: disposeBag)
        
    }
    
    /// MARK: 1:1 소모임 버튼 눌렀을 때 업데이트
    private func updateJoinFirstBtn(_ check: Bool){
        if check{
            self.secondJoinSelection.backgroundColor = UIColor(hexCode: "F5F5F5")
            self.thirdJoinSelection.backgroundColor = UIColor(hexCode: "F5F5F5")
            self.firstJoinSelection.backgroundColor = .blue
        }
        else{
            self.firstJoinSelection.backgroundColor = UIColor(hexCode: "F5F5F5")
        }
    }
    
    /// MARK: 2인 이상 모임 버튼 눌렀을 때 업데이트
    private func updateJoinSecondBtn(_ check: Bool){
        if check{
            self.firstJoinSelection.backgroundColor = UIColor(hexCode: "F5F5F5")
            self.thirdJoinSelection.backgroundColor = UIColor(hexCode: "F5F5F5")
            self.secondJoinSelection.backgroundColor = .blue
        }
        else{
            self.secondJoinSelection.backgroundColor = UIColor(hexCode: "F5F5F5")
        }
    }
    
    /// MARK: 인원 설정하기 버튼 눌렀을 때 업데이트
    private func updateJoinThirdBtn(_ check: Bool){
        if check{
            self.secondJoinSelection.backgroundColor = UIColor(hexCode: "F5F5F5")
            self.firstJoinSelection.backgroundColor = UIColor(hexCode: "F5F5F5")
            self.thirdJoinSelection.backgroundColor = .blue
        }
        else{
            self.thirdJoinSelection.backgroundColor = UIColor(hexCode: "F5F5F5")
        }
    }
    
    /// MARK:  모집 중인 모임만 보기 업데이트
    private func updateCheckOnceLook(_ check: Bool){
        if check{
            lookOnce.backgroundColor = .blue
        }
        else{
            lookOnce.backgroundColor = UIColor(hexCode: "F5F5F5")
        }
    }
    
    /// MARK:  나이 선택시 업데이트 하는 함수
    private func updateAgeItem(_ item: IndexPath){
        for indexPath in ageCollectionView.indexPathsForVisibleItems {
            let cell = ageCollectionView.cellForItem(at: indexPath) as? AgeCollectionViewCell
            if item == indexPath {
                cell?.backgroundColor = UIColor.blue
            }
            else{
                cell?.backgroundColor = UIColor(hexCode: "F5F5F5")
            }
        }
    }
    
    /// MARK: 선택된 셀 업데이트 하는 함수
    private func updateInterestingTopicItems(_ items: Set<IndexPath>) {
        for indexPath in interestingTopicCollectionView.indexPathsForVisibleItems {
            let cell = interestingTopicCollectionView.cellForItem(at: indexPath) as? InterestingTopicCollectionViewCell
            if items.contains(indexPath) {
                cell?.backgroundColor = UIColor.blue
            }
            else{
                cell?.backgroundColor = UIColor(hexCode: "F5F5F5")
            }
        }
    }
}


extension FilteringViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ageCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AgeCollectionViewCell.identifier, for: indexPath) as? AgeCollectionViewCell else {return UICollectionViewCell() }
            
            cell.backgroundColor = UIColor(hexCode: "F5F5F5")
            cell.inputData(text: MeetingFiltering.ageList[indexPath.row])
            return cell
        }
        else if collectionView == interestingTopicCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestingTopicCollectionViewCell.identifier, for: indexPath) as? InterestingTopicCollectionViewCell else {return UICollectionViewCell() }
            
            cell.backgroundColor = UIColor(hexCode: "F5F5F5")
            cell.layer.cornerRadius = 20
            cell.layer.borderColor = UIColor(hexCode: "DADADA").cgColor
            
            cell.inputData(text: MeetingFiltering.interestingTopicList[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ageCollectionView{
            return MeetingFiltering.ageList.count
        }
        else if collectionView == interestingTopicCollectionView{
            return MeetingFiltering.interestingTopicList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == ageCollectionView{
            viewModel.selectedAgeItem(at: indexPath)
        }
        else if collectionView == interestingTopicCollectionView{
            viewModel.selectedInterestingTopicItems(at: indexPath)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == ageCollectionView{
            return CGSize(width: collectionView.bounds.width/4-10, height: collectionView.bounds.height)
        }
        else if collectionView == interestingTopicCollectionView{
            return CGSize(width: collectionView.bounds.width/3-10, height: collectionView.bounds.height/3-10)
        }
        return CGSize()
    }
}
