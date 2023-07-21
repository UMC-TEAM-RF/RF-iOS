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
    
    // MARK: 달력 View
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
        cal.appearance.headerTitleFont = .boldSystemFont(ofSize: 25)
        cal.appearance.headerTitleAlignment = .left
        
        cal.appearance.separators = .interRows
        cal.appearance.titleFont = .systemFont(ofSize: 20)
        
        return cal
    }()
    
    /// MARK: 선택된 셀 Custom View
    private lazy var customCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "FE4700")
        view.layer.cornerRadius = 5
        view.isHidden = true
        
        return view
    }()
    
    
    private var eventList: [ScheduleEvent] = []
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        getData()
        addSubviews()
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        view.addSubview(calendarView)
        view.addSubview(customCircleView)
        
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
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: Change Date -> String
    private func formattingDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd E"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter.string(from: date)
    }
    
    /// MARK:
    private func getData(){
        eventList.append(ScheduleEvent(date: "2023-07-09", description: "축구 경기",color: "FE4700"))
        eventList.append(ScheduleEvent(date: "2023-07-11", description: "스터디",color: "FE4700"))
        eventList.append(ScheduleEvent(date: "2023-07-01", description: "야구 경기",color: "FE4700"))
        eventList.append(ScheduleEvent(date: "2023-07-25", description: "마라탕 먹방",color: "FE4700"))
        eventList.append(ScheduleEvent(date: "2023-07-25", description: "마라탕 먹방",color: "FE4700"))
        eventList.append(ScheduleEvent(date: "2023-07-25", description: "마라탕 먹방",color: "FE4700"))
        eventList.append(ScheduleEvent(date: "2023-07-25", description: "마라탕 먹방",color: "FE4700"))
        eventList.append(ScheduleEvent(date: "2023-07-25", description: "마라탕 먹방",color: "FE4700"))
        eventList.append(ScheduleEvent(date: "2023-07-31", description: "집에 가기",color: "FE4700"))
        eventList.append(ScheduleEvent(date: "2023-07-31", description: "놀러 가기",color: "FE4700"))
        eventList.append(ScheduleEvent(date: "2023-07-31", description: "놀러 가기",color: "FE4700"))
        eventList.append(ScheduleEvent(date: "2023-07-31", description: "놀러 가기",color: "FE4700"))
        eventList.append(ScheduleEvent(date: "2023-07-31", description: "놀러 가기",color: "FE4700"))
    }
}

extension ScheduleViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance{
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleOffsetFor date: Date) -> CGPoint {
        appearance.titleFont = .systemFont(ofSize: 10)
        return CGPoint(x: 10, y: -30)
    }
    
    /// 선택했을 때 색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return .clear
    }
    
    /// cell의 default color 변경
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        appearance.titleTodayColor = .black
        return .clear
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let cell = calendar.cell(for: date, at: monthPosition) else { return }
        print(formattingDate(date: date))
        cell.titleLabel.textColor = .black
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        guard let cell = calendar.dequeueReusableCell(withIdentifier: ScheduleFSCalendarCell.identifier, for: date, at: position) as? ScheduleFSCalendarCell else { return FSCalendarCell()}
        let date = formattingDate(date: date).split(separator: " ")[0]
        let event = self.eventList.filter({date == $0.date ?? ""})
        if !event.isEmpty{
            cell.inputData(events: event)
        }
        return cell
    }
    
    
    
}

struct ScheduleEvent{
    let date: String?
    let description: String?
    let color: String?
}

