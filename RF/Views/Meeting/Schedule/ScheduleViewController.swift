//
//  ScheduleViewController.swift
//  RF
//
//  Created by 정호진 on 2023/07/21.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift
import FSCalendar

final class ScheduleViewController: UIViewController{
    
    /// MARK: 달력 View
    private lazy var calendarView: FSCalendar = {
        let cal = FSCalendar()
        cal.backgroundColor = .clear
        cal.scope = .month
        cal.scrollEnabled = true
        cal.scrollDirection = .vertical
        
        cal.appearance.weekdayTextColor = .black
        /// 제목 부분
        cal.appearance.headerDateFormat = "YYYY년 MM월"
        cal.appearance.headerMinimumDissolvedAlpha = 0.0   /// 0으로 설정 시 옆 부분 날짜 안보임
        cal.appearance.headerTitleFont = .systemFont(ofSize: 20, weight: .bold)
        cal.appearance.headerTitleAlignment = .left
        cal.appearance.headerTitleColor = .black
        
        cal.appearance.separators = .interRows
        cal.appearance.titleFont = .systemFont(ofSize: 20)
        
        return cal
    }()
    
    /// MARK: 모임 검색 버튼
    private lazy var searchButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "magnifyingglass")?.resize(newWidth: 25), for: .normal)
        return btn
    }()
    
    /// MARK: 일정 생성 버튼
    private lazy var createButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus")?.resize(newWidth: 25), for: .normal)
        return btn
    }()
    
    private let viewModel = ScheduleViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        getData()
        addSubviews()
        clickedButtons()
    }
    
    // MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.toolbar.isHidden = true
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        view.addSubview(calendarView)
        view.addSubview(searchButton)
        view.addSubview(createButton)
        
        
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.register(ScheduleFSCalendarCell.self, forCellReuseIdentifier: ScheduleFSCalendarCell.identifier)
        
        configureConstraints()
    }
    
    /// MARK: Setting AutoLayout
    private func configureConstraints(){
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-1)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(1)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(calendarView.calendarHeaderView.snp.centerY)
            make.trailing.equalTo(createButton.snp.leading).offset(-20)
        }
        
        createButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(calendarView.calendarHeaderView.snp.centerY)
            
        }
    }
    
    /// MARK: 버튼 클릭 시 실행
    private func clickedButtons(){
        createButton.rx.tap
            .bind {
                print("clicked createButton")
            }
            .disposed(by: disposeBag)
        
        searchButton.rx.tap
            .bind {
                print("clicked searchButton")
            }
            .disposed(by: disposeBag)
    }
    
    /// MARK: ViewModel에서 데이터 얻는 함수
    private func getData(){
        viewModel.getData()
    }


}

extension ScheduleViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance{
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleOffsetFor date: Date) -> CGPoint {
        appearance.titleFont = .systemFont(ofSize: 10)
        return CGPoint(x: 10, y: -30)
    }
    
    /// 선택했을 때 색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? { return .clear }
    
    /// cell의 default color 변경
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        appearance.titleTodayColor = .black
        return .clear
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let cell = calendar.cell(for: date, at: monthPosition) else { return }
        cell.titleLabel.textColor = .black
        
        print(viewModel.formattingDate(date: date))
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        guard let cell = calendar.dequeueReusableCell(withIdentifier: ScheduleFSCalendarCell.identifier, for: date, at: position) as? ScheduleFSCalendarCell else { return FSCalendarCell()}

        viewModel.dateFiltering(date: date)
            .subscribe(onNext:{ list in
                cell.inputData(events: list)
            })
            .disposed(by: disposeBag)
        
        return cell
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        viewModel.getData()
    }

}
