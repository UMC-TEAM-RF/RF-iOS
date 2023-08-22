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
    
    
    
    /// MARK: 모집 연령대 제목
    private lazy var joinStatusTitleLabel: UILabel = {
        let label = UILabel()
        label.text = MeetingFiltering.joinStatus
        label.textColor = TextColor.first.color
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    /// MARK: 모집 상태 CollectionView
    private lazy var joinStatusCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        return cv
    }()
    
    /// MARK: 모집 연령대 제목
    private lazy var ageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = MeetingFiltering.ageTitle
        label.textColor = TextColor.first.color
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
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
        label.textColor = TextColor.first.color
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    /// MARK: 모집 인원 설정 CollectionView
    private lazy var joinNumberCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        return cv
    }()

    
    /// MARK: 관심 주제 설정 제목
    private lazy var interestingTopicTitleLabel: UILabel = {
        let label = UILabel()
        label.text = MeetingFiltering.interestingTitle
        label.textColor = TextColor.first.color
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
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
        btn.setImage(UIImage(systemName: "arrow.counterclockwise")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.setTitle(MeetingFiltering.filterClear, for: .normal)
        btn.setTitleColor(TextColor.first.color, for: .normal)
        btn.backgroundColor = .clear
        return btn
    }()
    
    /// MARK: 완료버튼
    private lazy var doneButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        btn.setTitle(MeetingFiltering.done, for: .normal)
        btn.setTitleColor(BackgroundColor.white.color, for: .normal)
        btn.backgroundColor = ButtonColor.main.color
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = FilteringViewModel()
    
    /// 선택된 관심 주제 목록
    var interestingTopicRelay = BehaviorRelay<Set<IndexPath>>(value: [])
    
    /// 선택한 연령 대
    var ageRelay = BehaviorRelay<IndexPath>(value: IndexPath())
    
    /// 모집 상태
    var joinStatusRelay = BehaviorRelay<IndexPath>(value: IndexPath())
    
    /// 모집 인원
    var joinNumberRelay = BehaviorRelay<IndexPath>(value: IndexPath())
    
    var checkRelay = BehaviorRelay<Bool>(value: false)
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        clickedBtns()
        getDataFromViewModel()
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        view.addSubview(joinStatusTitleLabel)
        view.addSubview(joinStatusCollectionView)
        view.addSubview(ageTitleLabel)
        view.addSubview(ageCollectionView)
        view.addSubview(joinNumberTitleLabel)
        view.addSubview(joinNumberCollectionView)
        view.addSubview(interestingTopicTitleLabel)
        view.addSubview(interestingTopicCollectionView)
        view.addSubview(filterClearBtn)
        view.addSubview(doneButton)
        
        joinStatusCollectionView.delegate = self
        joinStatusCollectionView.dataSource = self
        joinStatusCollectionView.register(AgeCollectionViewCell.self, forCellWithReuseIdentifier: AgeCollectionViewCell.identifier)
        
        joinNumberCollectionView.delegate = self
        joinNumberCollectionView.dataSource = self
        joinNumberCollectionView.register(AgeCollectionViewCell.self, forCellWithReuseIdentifier: AgeCollectionViewCell.identifier)
        
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
  
        joinStatusTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        joinStatusCollectionView.snp.makeConstraints { make in
            make.top.equalTo(joinStatusTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/28)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        filterClearBtn.snp.makeConstraints { make in
            make.centerY.equalTo(joinStatusTitleLabel.snp.centerY)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        ageTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(joinStatusCollectionView.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        ageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(ageTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/28)
        }
        
        joinNumberTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(ageCollectionView.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        joinNumberCollectionView.snp.makeConstraints { make in
            make.top.equalTo(joinNumberTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/28)
        }
        
        
        interestingTopicTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(joinNumberCollectionView.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        interestingTopicCollectionView.snp.makeConstraints { make in
            make.top.equalTo(interestingTopicTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/6)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(interestingTopicCollectionView.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/20)
        }
       
    }
    
    /// MARK: 버튼들 클릭 했을 때 실행
    private func clickedBtns(){
        
        doneButton.rx.tap
            .bind { [weak self] in
                self?.interestingTopicRelay.accept(self?.viewModel.interestingTopicRelay.value ?? [])
                self?.ageRelay.accept(self?.viewModel.ageRelay.value ?? IndexPath())
                self?.joinNumberRelay.accept(self?.viewModel.joinNumberRelay.value ?? IndexPath())
                self?.joinStatusRelay.accept(self?.viewModel.joinStatusRelay.value ?? IndexPath())
                self?.checkRelay.accept(true)
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        filterClearBtn.rx.tap
            .bind(onNext: {
                self.viewModel.clickResetBtn()
            })
            .disposed(by: disposeBag)
      
    }
    
    /// MARK: ViewModel에서 데이터를 받아오는 함수
    private func getDataFromViewModel(){
        viewModel.interestingTopicRelay.accept(interestingTopicRelay.value)
        viewModel.ageRelay.accept(ageRelay.value)
        viewModel.joinStatusRelay.accept(joinStatusRelay.value)
        viewModel.joinNumberRelay.accept(joinNumberRelay.value)
        
        viewModel.ageRelay
            .subscribe(onNext: { [weak self] item in
                self?.updateAgeItem(item)
            })
            .disposed(by: disposeBag)
        
        // 선택된 관심 주제 가져옴
        viewModel.interestingTopicRelay
            .subscribe(onNext: { [weak self] items in
                self?.updateInterestingTopicItems(items)
            })
            .disposed(by: disposeBag)
        
        viewModel.joinStatusRelay
            .bind { [weak self] item in
                self?.updatejoinStatusItem(item)
            }
            .disposed(by: disposeBag)
        
        
        viewModel.joinNumberRelay
            .bind { [weak self] item in
                self?.updateJoinNumberItem(item)
            }
            .disposed(by: disposeBag)
    }

    /// MARK:  모집 상태 업데이트 하는 함수
    private func updatejoinStatusItem(_ item: IndexPath){
        for indexPath in joinStatusCollectionView.indexPathsForVisibleItems {
            let cell = joinStatusCollectionView.cellForItem(at: indexPath) as? AgeCollectionViewCell
            if item == indexPath {
                cell?.backgroundColor = ButtonColor.main.color
                cell?.setColor(color: BackgroundColor.white.color)
            }
            else{
                cell?.backgroundColor = BackgroundColor.gray.color
                cell?.setColor(color: TextColor.first.color)
            }
        }
    }
    
    
    /// MARK:  나이 선택시 업데이트 하는 함수
    private func updateAgeItem(_ item: IndexPath){
        for indexPath in ageCollectionView.indexPathsForVisibleItems {
            let cell = ageCollectionView.cellForItem(at: indexPath) as? AgeCollectionViewCell
            if item == indexPath {
                cell?.backgroundColor = ButtonColor.main.color
                cell?.setColor(color: BackgroundColor.white.color)
            }
            else{
                cell?.backgroundColor = BackgroundColor.gray.color
                cell?.setColor(color: TextColor.first.color)
            }
        }
    }
    
    /// MARK:  모집 인원 선택 시 업데이트 하는 함수
    private func updateJoinNumberItem(_ item: IndexPath){
        for indexPath in joinNumberCollectionView.indexPathsForVisibleItems {
            let cell = joinNumberCollectionView.cellForItem(at: indexPath) as? AgeCollectionViewCell
            if item == indexPath {
                cell?.backgroundColor = ButtonColor.main.color
                cell?.setColor(color: BackgroundColor.white.color)
            }
            else{
                cell?.backgroundColor = BackgroundColor.gray.color
                cell?.setColor(color: TextColor.first.color)
            }
        }
    }
    
    /// MARK: 선택된 셀 업데이트 하는 함수
    private func updateInterestingTopicItems(_ items: Set<IndexPath>) {
        for indexPath in interestingTopicCollectionView.indexPathsForVisibleItems {
            let cell = interestingTopicCollectionView.cellForItem(at: indexPath) as? InterestingTopicCollectionViewCell
            if items.contains(indexPath) {
                cell?.backgroundColor = ButtonColor.main.color
                cell?.setColor(color: BackgroundColor.white.color)
            }
            else{
                cell?.backgroundColor = BackgroundColor.gray.color
                cell?.setColor(color: TextColor.first.color)
            }
        }
    }
}


extension FilteringViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == joinStatusCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AgeCollectionViewCell.identifier, for: indexPath) as? AgeCollectionViewCell else {return UICollectionViewCell() }
            
            if viewModel.checkJoinStatusItem(at: indexPath){
                cell.backgroundColor = ButtonColor.main.color
                cell.setColor(color: BackgroundColor.white.color)
            }
            else{
                cell.backgroundColor = BackgroundColor.gray.color
                cell.setColor(color: TextColor.first.color)
            }
            
            cell.layer.cornerRadius = 10
            cell.inputData(text: MeetingFiltering.joinStatusList[indexPath.row])
            return cell
        }
        else if collectionView == ageCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AgeCollectionViewCell.identifier, for: indexPath) as? AgeCollectionViewCell else {return UICollectionViewCell() }
            
            if viewModel.checkRemainAgeItem(at: indexPath){
                cell.backgroundColor = ButtonColor.main.color
                cell.setColor(color: BackgroundColor.white.color)
            }
            else{
                cell.backgroundColor = BackgroundColor.gray.color
                cell.setColor(color: TextColor.first.color)
            }
            
            cell.layer.cornerRadius = 10
            cell.inputData(text: MeetingFiltering.ageList[indexPath.row])
            return cell
        }
        else if collectionView == joinNumberCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AgeCollectionViewCell.identifier, for: indexPath) as? AgeCollectionViewCell else {return UICollectionViewCell() }
            
            if viewModel.checkRemainjoinNumberItems(at: indexPath){
                cell.backgroundColor = ButtonColor.main.color
                cell.setColor(color: BackgroundColor.white.color)
            }
            else{
                cell.backgroundColor = BackgroundColor.gray.color
                cell.setColor(color: TextColor.first.color)
            }
            
            cell.layer.cornerRadius = 10
            cell.inputData(text: MeetingFiltering.joinNumberList[indexPath.row])
            return cell
        }
        else if collectionView == interestingTopicCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestingTopicCollectionViewCell.identifier, for: indexPath) as? InterestingTopicCollectionViewCell else {return UICollectionViewCell() }
            
            if viewModel.checkRemainInterestingTopicItems(at: indexPath){
                cell.backgroundColor = ButtonColor.main.color
                cell.setColor(color: BackgroundColor.white.color)
            }
            else{
                cell.backgroundColor = BackgroundColor.gray.color
                cell.setColor(color: TextColor.first.color)
            }
            
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = BackgroundColor.dark.color.cgColor
            cell.inputData(text: EnumFile.enumfile.enumList.value.interest?[indexPath.row].value ?? "")
            cell.inputData(text: MeetingFiltering.interestingTopicList[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == joinStatusCollectionView{
            return MeetingFiltering.joinStatusList.count
        }
        else if collectionView == ageCollectionView{
            return MeetingFiltering.ageList.count
        }
        else if collectionView == joinNumberCollectionView{
            return MeetingFiltering.joinNumberList.count
        }
        else if collectionView == interestingTopicCollectionView{
            return EnumFile.enumfile.enumList.value.interest?.count ?? 0

        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == joinStatusCollectionView{
            viewModel.selectedjoinStatusItem(at: indexPath)
        }
        else if collectionView == ageCollectionView{
            viewModel.selectedAgeItem(at: indexPath)
        }
        else if collectionView == joinNumberCollectionView{
            viewModel.selectedJoinNumberItem(at: indexPath)
        }
        else if collectionView == interestingTopicCollectionView{
            viewModel.selectedInterestingTopicItems(at: indexPath)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == joinStatusCollectionView{
            let joinStatus = MeetingFiltering.joinStatusList[indexPath.row]
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let newSize = (joinStatus as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
            
            return CGSize(width: newSize.width + 30, height: collectionView.bounds.height)
        }
        else if collectionView == ageCollectionView{
            let age = MeetingFiltering.ageList[indexPath.row]
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let newSize = (age as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
            
            return CGSize(width: newSize.width + 30, height: collectionView.bounds.height)
        }
        else if collectionView == joinNumberCollectionView{
            let joinNumber = MeetingFiltering.joinNumberList[indexPath.row]
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let newSize = (joinNumber as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
            
            return CGSize(width: newSize.width + 30, height: collectionView.bounds.height)
        }
        else if collectionView == interestingTopicCollectionView{
            return CGSize(width: collectionView.bounds.width/3-10, height: collectionView.bounds.height/3-10)
        }
        return CGSize()
    }
}
