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
        cal.appearance.headerTitleColor = .white
        
        
        cal.appearance.separators = .interRows
        cal.appearance.titleFont = .systemFont(ofSize: 20)
        
        return cal
    }()
    
    /// MARK: 뒤로가기 버튼
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.left")?.resize(newWidth: 15), for: .normal)
        return btn
    }()
    
    /// MARK: Calendar Header View 달 표시 하는 버튼
    private lazy var headerButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(TextColor.first.color, for: .normal)
        btn.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.semanticContentAttribute = .forceRightToLeft
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
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
        view.addSubview(backButton)
        view.addSubview(headerButton)
        
        
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
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(calendarView.calendarHeaderView.snp.centerY)
            make.leading.equalToSuperview().offset(20)
        }
        
        headerButton.snp.makeConstraints { make in
            make.centerY.equalTo(calendarView.calendarHeaderView.snp.centerY)
            make.leading.equalTo(backButton.snp.trailing).offset(20)
        }
    }
    
    /// MARK: 버튼 클릭 시 실행
    private func clickedButtons(){
        
        headerButton.rx.tap
            .bind {
                print("clicked header Button")
            }
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    /// MARK: ViewModel에서 데이터 얻는 함수
    private func getData(){
        let date = viewModel.formattingDate_HeaderView(date: calendarView.currentPage)
        print(date)
        viewModel.getData(year: String(date.split(separator: "-")[0]), month: String(date.split(separator: "-")[1]))
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
        
        let schedulePopUpViewController = SchedulePopUpViewController()
        schedulePopUpViewController.selectedDate.onNext(String(describing: viewModel.formattingDate(date: date).split(separator: " ").first))
        present(schedulePopUpViewController,animated: true)
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        guard let cell = calendar.dequeueReusableCell(withIdentifier: ScheduleFSCalendarCell.identifier, for: date, at: position) as? ScheduleFSCalendarCell else { return FSCalendarCell()}
        
        cell.backgroundColor = .clear
        headerButton.setTitle("\(viewModel.formattingDate_HeaderView(date: calendarView.currentPage)) ", for: .normal)
        
        viewModel.dateFiltering(date: date)
            .subscribe(onNext:{ list in
                cell.inputData(events: list)
            })
            .disposed(by: disposeBag)
        
        return cell
    }
    
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let date = viewModel.formattingDate_HeaderView(date: calendarView.currentPage)
        print(date)
        viewModel.getData(year: String(date.split(separator: "-")[0]), month: String(date.split(separator: "-")[1]))
        calendar.reloadData()
    }

}

