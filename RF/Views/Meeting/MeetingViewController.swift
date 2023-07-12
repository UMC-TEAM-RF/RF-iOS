//
//  MeetingViewController.swift
//  RF
//
//  Created by 정호진 on 2023/07/06.
//

import Foundation
import SnapKit
import UIKit
import RxSwift
import RxCocoa

final class MeetingViewController: UIViewController{
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        addSubviews()
        clickedTopBtns()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: 모임 제목 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "모임"
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    // MARK: 모임 찾기 버튼
    private lazy var searchMeetingBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "magnifyingglass")?.resize(newWidth: 25), for: .normal)
        return btn
    }()
    
    // MARK: 모임 생성 버튼
    private lazy var createMeetingBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus")?.resize(newWidth: 25), for: .normal)
        return btn
    }()
    
    // MARK: 모임 찾기 버튼, 모임 생성 버튼 담는 StackView
    private lazy var btnsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [searchMeetingBtn, createMeetingBtn])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .systemBackground
        stack.spacing = 10
        return stack
    }()
    
    // MARK: 모임 찾기, 모임 생성하기 UIView
    private lazy var makeFriendView: MakeFriendUIView = {
        let view = MakeFriendUIView()
        view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0) /* #f9f9f9 */
        view.layer.cornerRadius = 20
        return view
    }()
    
    // MARK: 근처 모임 리스트 View
    private lazy var meetingListView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var meetingListLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 OO님 근처의 모임을 확인 해보세요!"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var meetingCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 15
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.isScrollEnabled = false
        return cv
    }()
    
    // MARK: add UI
    private func addSubviews(){
        view.addSubview(titleLabel)
        view.addSubview(btnsStackView)
        view.addSubview(makeFriendView)
        view.addSubview(meetingListView)
        
        meetingListView.addSubview(meetingListLabel)
        meetingListView.addSubview(meetingCollectionView)
        
        configureConstraints()
        uiActions()
    }
    
    // MARK: setting AutoLayout
    private func configureConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        btnsStackView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        makeFriendView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height*2/5)
        }
        
        // 모임
        meetingListView.snp.makeConstraints { make in
            make.top.equalTo(makeFriendView.snp.bottom).offset(50)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        meetingListLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
        
        meetingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(meetingListLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            
            //make.bottom.equalToSuperview()
            
            make.height.equalTo(130)    // 1개 130, 2개 275, 3개 420
        }
    }
    
    // MARK: - configureCollectionView
    private func configureCollectionView() {
        meetingCollectionView.delegate = self
        meetingCollectionView.dataSource = self
        
        meetingCollectionView.register(MeetingCollectionViewCell.self, forCellWithReuseIdentifier: "MeetingCollectionViewCell")
    }
    
    // MARK:
    private func uiActions(){
        makeFriendView.inputData(height: view.safeAreaLayoutGuide.layoutFrame.width)
        makeFriendView.delegate = self
    }
    
    // MARK: 모임 찾기, 모임 생성 버튼 눌렀을 때
    private func clickedTopBtns(){
        searchMeetingBtn.rx.tap
            .subscribe(onNext:{
                print("clicked searchMeetingBtn")
            })
            .disposed(by: disposeBag)
        
        createMeetingBtn.rx.tap
            .subscribe(onNext:{
                print("clicked createMeetingBtn")
            })
            .disposed(by: disposeBag)
    }
    
    
    
}

extension MeetingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: meetingCollectionView.frame.width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MeetingCollectionViewCell", for: indexPath) as! MeetingCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meetingTabController = DetailMeetingTabController()
        navigationController?.pushViewController(meetingTabController, animated: true)
    }
    
}

extension MeetingViewController: ClickedButton {
    /// true -> 모임 찾기 버튼
    /// false -> 모임 생성하기
    func clickedBtns(check: Bool) {
        if check{
            print("clicked searchMeeting")
        }
        else{
            print("clicked createMeeting")
            tabBarController?.tabBar.isHidden = true
            navigationController?.pushViewController(SetMeetingNameViewController(), animated: true)
        }
    }
    
}


// 파일 옮기기

