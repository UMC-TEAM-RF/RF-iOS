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

/// MARK: 모임 홈 화면
final class MeetingViewController: UIViewController{
    
    /// MARK: 모임 제목 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "모임"
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    /// MARK: 모임 찾기 버튼
    private lazy var alertButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "bell")?.resize(newWidth: 25), for: .normal)
        return btn
    }()
    
    /// MARK: 모임 생성 버튼
    private lazy var etcButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "ellipsis")?.resize(newWidth: 25).rotate(degrees: 90), for: .normal)
        btn.showsMenuAsPrimaryAction = true
        return btn
    }()
    
    /// MARK: 모임 찾기 버튼, 모임 생성 버튼 담는 StackView
    private lazy var btnsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [alertButton, etcButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .systemBackground
        stack.spacing = 10
        return stack
    }()
    
    /// MARK: 모임 찾기, 모임 생성하기 UIView
    private lazy var makeFriendView: MakeFriendUIView = {
        let view = MakeFriendUIView()
        view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0) /* #f9f9f9 */
        view.layer.cornerRadius = 20
        return view
    }()
    
    /// MARK: 근처 모임 리스트 View
    private lazy var meetingListView: UIView = {
        let view = UIView()
        return view
    }()
    
    /// MARK: 모임 제목
    private lazy var meetingListLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 OO님 근처의 모임을 확인 해보세요!"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    /// MARK: 모임 CollectionView
    private lazy var meetingCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 15
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.isScrollEnabled = false
        return cv
    }()
    
    private let disposeBag = DisposeBag()
    
    // MARK:  - init
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
    
    // MARK: - Functions
    
    /// MARK: add UI
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
    
    /// MARK: setting AutoLayout
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
    
    /// MARK: - configureCollectionView
    private func configureCollectionView() {
        meetingCollectionView.delegate = self
        meetingCollectionView.dataSource = self
        
        meetingCollectionView.register(MeetingCollectionViewCell.self, forCellWithReuseIdentifier: "MeetingCollectionViewCell")
    }
    
    /// MARK: UI Action 함수
    private func uiActions(){
        makeFriendView.inputData(height: view.safeAreaLayoutGuide.layoutFrame.width)
        makeFriendView.delegate = self
    }
    
    /// MARK: 모임 찾기, 모임 생성 아이콘 버튼 눌렀을 때
    private func clickedTopBtns(){
        alertButton.rx.tap
            .subscribe(onNext:{
                print("clicked alertButton")
            })
            .disposed(by: disposeBag)
        
        let schedule = UIAction(title: "모임 일정", image: nil, handler: { [weak self] _ in
            let scheduleViewController = ScheduleViewController()
            self?.tabBarController?.tabBar.isHidden = true
            self?.navigationController?.pushViewController(scheduleViewController, animated: true)
        })
        
        let list = UIAction(title: "모임 목록", image: nil, handler: { [weak self] _ in
            let listViewController = ListViewController()
            self?.tabBarController?.tabBar.isHidden = true
            self?.navigationItem.hidesBackButton = false
            self?.navigationItem.leftItemsSupplementBackButton = true
            self?.navigationController?.pushViewController(listViewController, animated: true)
        })
        
        etcButton.menu = UIMenu(title: "ETC",
                                  image: nil,
                                  identifier: nil,
                                  options: .displayInline,
                                  children: [schedule,list])
        
    }
    
    /// MARK: 생성하기 팝업 뷰가 뜬 후 실행되는 함수
    private func clickedCreateButtons(){
        tabBarController?.tabBar.isHidden = true
        let setMeetingNameViewController = SetMeetingNameViewController()
        navigationController?.pushViewController(setMeetingNameViewController, animated: true)
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

extension MeetingViewController: SendDataDelegate {
    /// true -> 모임 찾기 버튼
    /// false -> 모임 생성하기
    func sendBooleanData(_ data: Bool) {
        if data {
            print("clicked searchMeeting")
            let searchingViewController = SearchingViewController()
            tabBarController?.tabBar.isHidden = true
            self.navigationController?.pushViewController(searchingViewController, animated: true)
        } else {
            print("clicked createMeeting")
            tabBarController?.tabBar.isHidden = true
            navigationController?.navigationBar.isHidden = false
            navigationController?.pushViewController(SetMeetingNameViewController(), animated: true)
        }
    }
}
