//
//  CreateCalendarViewController.swift
//  RF
//
//  Created by 정호진 on 10/8/23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

/// 일정 생성
final class CreateCalendarViewController: UIViewController {
    
    /// MARK: 일정 제목
    private lazy var calendarTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "일정 제목"
        return label
    }()
    
    /// MARK: 일정 제목 입력
    private lazy var calendarTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "제목을 입력해주세요"
        return field
    }()
    
    /// MARK: 시작 제목
    private lazy var startLabel: UILabel = {
        let label = UILabel()
        label.text = "시작"
        return label
    }()
    
    /// MARK: 시작 날짜
    private lazy var startPicker: UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.locale = Locale(identifier: "ko-KR")
        view.backgroundColor = .white
        return view
    }()
    
    /// MARK:  장소 제목
    private lazy var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "장소"
        return label
    }()
    
    /// MARK: 장소
    private lazy var locationTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "제목을 입력해주세요"
        return field
    }()
    
    /// MARK: 시작 시간 제목
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        return label
    }()
    
    /// MARK: 시작 날짜
    private lazy var timePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .time
        view.locale = Locale(identifier: "ko-KR")
        return view
    }()
    
    /// MARK:  알림 받기
    private lazy var alermTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "알림"
        return label
    }()
    
    /// MARK: 장소
    private lazy var alermButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("응답 받음", for: .normal)
        btn.setTitleColor(.lightGray, for: .normal)
        return btn
    }()
    
    /// MARK: vertical Stack View
    private lazy var vStackView1: UIStackView = {
        let view = UIStackView(arrangedSubviews: [calendarTitleLabel,startLabel,locationTitleLabel,timeLabel,alermTitleLabel])
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 20
        return view
    }()
    
    /// MARK: vertical Stack View
    private lazy var vStackView2: UIStackView = {
        let view = UIStackView(arrangedSubviews: [calendarTextField,startPicker,locationTextField,timePicker,alermButton])
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 20
        return view
    }()
    
    /// MARK: horizontal Stack View
    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [vStackView1,vStackView2])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 10
        return view
    }()
    
    /// MARK: 완료 버튼
    private lazy var doneButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = BackgroundColor.gray.color
        btn.setTitle("완료", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    /// 알람 유무
    private var alermRelay: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    /// 장소
    private var locationRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// 시간
    private var timeRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// 날짜
    private var dateRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// 제목
    private var titleRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubViews()
        bind()
    }
    
    /// MARK: Add UI
    private func addSubViews(){
        view.addSubview(hStackView)
        view.addSubview(doneButton)
        
        constraints()
    }
    
    /// MARK: set autolayout
    private func constraints(){
        hStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(hStackView.snp.bottom).offset(30)
            make.leading.equalTo(vStackView1.snp.leading)
            make.trailing.equalTo(vStackView2.snp.trailing)
            make.height.equalTo(40)
        }
    }
    
    /// MARK: binding
    private func bind(){
        alermButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else {return}
                alermRelay.accept(!alermRelay.value)
                switch alermRelay.value {
                case true:
                    alermButton.setTitle("알람 받음", for: .normal)
                case false:
                    alermButton.setTitle("알람 받지 않음", for: .normal)
                }
            }
            .disposed(by: disposeBag)
        
        calendarTextField.rx.text
            .orEmpty
            .bind { [weak self] text in
                guard let self = self else {return}
                timeRelay.accept(text)
            }
            .disposed(by: disposeBag)
        
        locationTextField.rx.text
            .orEmpty
            .bind { [weak self] text in
                guard let self = self else {return}
                locationRelay.accept(text)
            }
            .disposed(by: disposeBag)
        
        startPicker.rx.date
            .bind { [weak self] date in
                guard let self = self else {return}
                dateRelay.accept(changeDateToString(dateFormat: "yyyy/MM/dd",date: date))
            }
            .disposed(by: disposeBag)
        
        timePicker.rx.date
            .bind { [weak self] time in
                guard let self = self else {return}
                timeRelay.accept(changeDateToString(dateFormat: "hh:mm:ss",date: time))
            }
            .disposed(by: disposeBag)
        
        doneButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else {return}
                //완료 버튼
            }
            .disposed(by: disposeBag)
        
    }
    
    /// MARK: DatePicker String타입으로 변환
    private func changeDateToString(dateFormat: String, date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let date: Date = date
        let dateToString: String = formatter.string(from: date)
        return dateToString
    }
    
}
