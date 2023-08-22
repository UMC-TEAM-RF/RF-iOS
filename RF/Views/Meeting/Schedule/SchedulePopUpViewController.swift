//
//  SchedulePopUpViewController.swift
//  RF
//
//  Created by 정호진 on 2023/07/28.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

/// MARK: 일정을 눌렀을 때 뜨는 팝업 창
final class SchedulePopUpViewController: DimmedViewController {
    
    /// MARK: Pop up 창 base view
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = BackgroundColor.white.color
        view.layer.cornerRadius = 30
        return view
    }()
    
    /// MARK: 모임 별명
    private lazy var meetingNickname: UILabel = {
        let label = UILabel()
        label.textColor = TextColor.first.color
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    /// MARK: 모임 이름
    private lazy var meetingName: UILabel = {
        let label = UILabel()
        label.textColor = TextColor.first.color
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    /// MARK: 날짜 제목
    private lazy var dateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = TextColor.first.color
        label.text = SchedulePopUp.date
        return label
    }()
    
    /// MARK: 이벤트 날짜
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = TextColor.first.color
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    /// MARK: 날짜 Label들 담는 view
    private lazy var dateUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    /// MARK: 시간 제목
    private lazy var timeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = SchedulePopUp.time
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 이벤트 시간
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 시간 Label들 담는 view
    private lazy var timeUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    
    /// MARK: 장소 제목
    private lazy var placeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = SchedulePopUp.place
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 이벤트 장소
    private lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 장소 Label들 담는 view
    private lazy var placeUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    /// MARK: 인원 제목
    private lazy var peopleTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = SchedulePopUp.people
        label.textColor = TextColor.first.color
        return label
    }()

    /// MARK: 이벤트 인원수
    private lazy var peopleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 인원 Label들 담는 view
    private lazy var peopleUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    /// MARK: 날짜, 시간, 장소, 인원 View 담는 stackview
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [dateUIView, timeUIView, placeUIView, peopleUIView])
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = SchedulePopUpViewModel()
    var selectedDate: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    // MARK: - init
    
    init() {
        super.init(durationTime: 0.3, alpha: 0.25)
        bind()
        addSubviews()
        getData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }
    
    // MARK: - Functions
    
    /// MARK: Add UI
    private func addSubviews(){
        view.addSubview(baseView)
        baseView.addSubview(meetingNickname)
        baseView.addSubview(meetingName)
        baseView.addSubview(stackView)
        
        dateUIView.addSubview(dateLabel)
        dateUIView.addSubview(dateTitleLabel)
        
        timeUIView.addSubview(timeLabel)
        timeUIView.addSubview(timeTitleLabel)
        
        placeUIView.addSubview(placeLabel)
        placeUIView.addSubview(placeTitleLabel)
        
        peopleUIView.addSubview(peopleLabel)
        peopleUIView.addSubview(peopleTitleLabel)
        
        configureConstraints()
    }
    
    /// MARK: Setting AutoLayout
    private func configureConstraints(){
        baseView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/4)
        }
        
        meetingNickname.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(baseView.snp.leading).offset(20)
            make.trailing.equalTo(baseView.snp.trailing).offset(-20)
        }
        
        meetingName.snp.makeConstraints { make in
            make.top.equalTo(meetingNickname.snp.bottom).offset(10)
            make.leading.equalTo(baseView.snp.leading).offset(20)
            make.trailing.equalTo(baseView.snp.trailing).offset(-20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(meetingName.snp.bottom).offset(20)
            make.leading.equalTo(baseView.snp.leading).offset(20)
            make.trailing.equalTo(baseView.snp.trailing).offset(-20)
            make.height.equalTo(baseView.snp.height).multipliedBy(0.5)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        dateTitleLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        timeTitleLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        
        placeLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        placeTitleLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        
        peopleLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        peopleTitleLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        
    }
    
    /// MARK: rxswift binding functions
    private func bind(){
        selectedDate.bind { [weak self] date in
            self?.viewModel.selectedDate.accept(date)
        }
        .disposed(by: disposeBag)
        
        
        viewModel.eventInformation.bind { [weak self] event in
            self?.meetingNickname.text = event.meetingNickname ?? ""
            self?.meetingName.text = event.meetingName ?? ""
            self?.dateLabel.text = event.date ?? ""
            self?.timeLabel.text = event.time ?? ""
            self?.placeLabel.text = event.place ?? ""
            self?.peopleLabel.text = event.peopleNum ?? ""
        }
        .disposed(by: disposeBag)
    }
    
    
    /// MARK: test Data
    private func getData(){
        viewModel.getData()
    }
}
