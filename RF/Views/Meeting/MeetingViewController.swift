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
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 모임 찾기, 모임 생성하기 UIView
    private lazy var makeFriendView: MakeFriendUIView = {
        let view = MakeFriendUIView()
        return view
    }()

    
    /// MARK: 나의 모임 기록 제목
    private lazy var meetingLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 모임 기록"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK:  모임 일정 관리
    private lazy var meetingScheduleUIButton: MeetingManageUIButton = {
        let btn = MeetingManageUIButton()
        btn.inputData(img: "calendar", title: "모임 일정 관리")
        btn.backgroundColor = ButtonColor.normal.color
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    /// MARK:  모임 목록 관리
    private lazy var meetingListUIButton: MeetingManageUIButton = {
        let btn = MeetingManageUIButton()
        btn.backgroundColor = ButtonColor.normal.color
        btn.inputData(img: "list", title: "모임 목록 관리")
        btn.layer.cornerRadius = 10
        return btn
    }()
  
    // 꿀팁 배너
    private lazy var tipsView: UIView = {
        let view = UIView()
        view.backgroundColor = BackgroundColor.gray.color
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var tipsImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "tips_icon")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var tipsLabelStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.backgroundColor = .clear
        return sv
    }()
    
    private lazy var tipsTopLabel: UILabel = {
        let label = UILabel()
        label.text = "외국인 친구들과 편하게 얘기하고 싶어?"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = TextColor.first.color
        return label
    }()
    
    private lazy var tipsBottomLabel: UILabel = {
        let label = UILabel()
        label.text = "꿀팁 얻으러 가기!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = TextColor.first.color
        return label
    }()
    
    
    
    private let disposeBag = DisposeBag()
    private let viewModel = MeetingViewModel()
    
    // MARK:  - init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        addSubviews()
        clickedTopBtns()
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
        view.addSubview(makeFriendView)
        view.addSubview(meetingLabel)
        view.addSubview(meetingScheduleUIButton)
        view.addSubview(meetingListUIButton)
        view.addSubview(tipsView)
        
        // 꿀팁
        tipsView.addSubview(tipsImage)
        tipsView.addSubview(tipsLabelStackView)
        tipsLabelStackView.addArrangedSubview(tipsTopLabel)
        tipsLabelStackView.addArrangedSubview(tipsBottomLabel)
        
        configureConstraints()
        uiActions()
        
    }
    
    /// MARK: setting AutoLayout
    private func configureConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        makeFriendView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            
        }
        
        
        meetingLabel.snp.makeConstraints { make in
            make.top.equalTo(makeFriendView.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        meetingScheduleUIButton.snp.makeConstraints { make in
            make.top.equalTo(meetingLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.height.equalTo(80)
        }
        
        meetingListUIButton.snp.makeConstraints { make in
            make.top.equalTo(meetingLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(80)
        }
        
        
        // 꿀팁
        tipsView.snp.makeConstraints { make in
            make.top.equalTo(meetingListUIButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(75)
        }
        
        tipsImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(tipsImage.snp.height).multipliedBy(1)
        }
        
        tipsLabelStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(tipsImage.snp.trailing).offset(10)
        }
    }
    
    /// MARK: UI Action 함수
    private func uiActions(){
        makeFriendView.inputData(height: view.safeAreaLayoutGuide.layoutFrame.width)
        makeFriendView.delegate = self
    }
    
    /// MARK: 모임 찾기, 모임 생성 아이콘 버튼 눌렀을 때
    private func clickedTopBtns(){
        meetingScheduleUIButton.rx.tap
            .bind { [weak self] in
                let scheduleViewController = ScheduleViewController()
                self?.tabBarController?.tabBar.isHidden = true
                self?.navigationController?.pushViewController(scheduleViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        meetingListUIButton.rx.tap
            .bind { [weak self] in
                let listViewController = ListViewController()
                self?.tabBarController?.tabBar.isHidden = true
                self?.navigationItem.hidesBackButton = false
                self?.navigationItem.leftItemsSupplementBackButton = true
                self?.navigationController?.pushViewController(listViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
    }
    
    /// MARK: 생성하기 팝업 뷰가 뜬 후 실행되는 함수
    private func clickedCreateButtons(){
        tabBarController?.tabBar.isHidden = true
        let setMeetingNameViewController = SetMeetingNameViewController()
        navigationController?.pushViewController(setMeetingNameViewController, animated: true)
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
