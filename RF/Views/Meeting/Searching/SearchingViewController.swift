//
//  SearchingViewController.swift
//  RF
//
//  Created by 정호진 on 2023/07/16.
//

import Foundation
import SnapKit
import UIKit
import RxCocoa
import RxSwift

/// MARK: 모임 검색하는 화면
final class SearchingViewController: UIViewController{
    
    /// MARK: 필터링 버튼
    private lazy var filteringBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = ButtonColor.normal.color
        btn.setTitle(MeetingFiltering.searching, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.setTitleColor(TextColor.first.color, for: .normal)
        btn.semanticContentAttribute = .forceRightToLeft
        return btn
    }()
    
    /// MARK: 검색 버튼
    private lazy var searchBtn: UISearchBar = {
        let btn = UISearchBar()
        btn.placeholder = "모임 이름을 입력해 주세요"
        return btn
    }()
    
    /// MARK: 검색 및 필터링 결과 값 보여줄 CollectionView
    private lazy var meetingListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isUserInteractionEnabled = true
        return cv
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = SearchingViewModel()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = false
        
        moveFilteringScreen()
        addSubviews()
        clickedBtns()
        viewModel.getData()
    }
    
    /// MARK: 필터링 화면 이동
    private func moveFilteringScreen(){
        let filteringScreen = FilteringViewController()
        filteringScreen.modalPresentationStyle = .formSheet
        filteringScreen.ageRelay.accept(viewModel.ageRelay.value)
        filteringScreen.interestingTopicRelay.accept(viewModel.interestingTopicRelay.value)
        filteringScreen.joinNumberRelay.accept(viewModel.joinNumberRelay.value)
        filteringScreen.joinStatusRelay.accept(viewModel.joinStatusRelay.value)
        
        filteringScreen.ageRelay
            .subscribe(onNext:{ [weak self] data in

                self?.viewModel.ageRelay.accept(data)
            })
            .disposed(by: disposeBag)
        
        filteringScreen.interestingTopicRelay
            .subscribe(onNext:{ [weak self] data in
                self?.viewModel.interestingTopicRelay.accept(data)
            })
            .disposed(by: disposeBag)
        
        filteringScreen.joinNumberRelay
            .subscribe(onNext:{ [weak self] data in
                self?.viewModel.joinNumberRelay.accept(data)
            })
            .disposed(by: disposeBag)
        
        filteringScreen.joinStatusRelay
            .subscribe(onNext:{ [weak self] data in
                self?.viewModel.joinStatusRelay.accept(data)
            })
            .disposed(by: disposeBag)
        
        present(filteringScreen, animated: true)
    }
    
    /// MARK: add UI
    private func addSubviews(){
        navigationItem.titleView = searchBtn
        searchBtn.delegate = self
        
        view.addSubview(filteringBtn)
        view.addSubview(meetingListCollectionView)
        meetingListCollectionView.register(DetailedMeetingCollectionViewCell.self, forCellWithReuseIdentifier: DetailedMeetingCollectionViewCell.identifier)
        meetingListCollectionView.dataSource = self
        meetingListCollectionView.delegate = self
        
        configureConstraints()
    }
    
    /// MARK: setting AutoLayout
    private func configureConstraints(){
        meetingListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(filteringBtn.snp.top)
        }
        
        filteringBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/20)
        }
    }
    
    /// MARK: 버튼들 클릭 했을 때 실행
    private func clickedBtns(){
        filteringBtn.rx.tap
            .bind { [weak self] in
                self?.moveFilteringScreen()
            }
            .disposed(by: disposeBag)
    }
    
    
    
}

extension SearchingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailedMeetingCollectionViewCell.identifier, for: indexPath) as? DetailedMeetingCollectionViewCell else { return UICollectionViewCell() }
        cell.meetingData = viewModel.meetingList.value[indexPath.row]
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.meetingList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-20, height: collectionView.frame.height/3)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailMeetingHomeController = DetailMeetingHomeController()
        detailMeetingHomeController.meetingIdRelay.accept(viewModel.meetingList.value[indexPath.row].id)
        navigationItem.backButtonTitle = " "
        navigationController?.pushViewController(detailMeetingHomeController, animated: true)
    }
    
    
}

extension SearchingViewController: UISearchBarDelegate {
    
}
