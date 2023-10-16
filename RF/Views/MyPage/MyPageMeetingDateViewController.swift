//
//  MyPageMeetingDateViewController.swift
//  RF
//
//  Created by 용용이 on 2023/10/07.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift
import FSCalendar

class MyPageMeetingDateViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    /// MARK: Custom 캘린더 헤더뷰
    private lazy var calenderDaysHeaderView: CalenderDaysHeaderView = {
        return CalenderDaysHeaderView()
    }()
    
    /// MARK: 달력 View
    private lazy var calendarView: FSCalendar = {
        let cal = FSCalendar()
        cal.backgroundColor = .clear
        cal.scope = .month
        cal.scrollEnabled = true
        cal.scrollDirection = .horizontal
        
        cal.appearance.weekdayTextColor = TextColor.secondary.color
        cal.appearance.weekdayFont = .systemFont(ofSize: 14, weight: .bold)
        /// 제목 부분
        cal.appearance.headerMinimumDissolvedAlpha = 0.0   /// 0으로 설정 시 옆 부분 날짜 안보임
        cal.headerHeight = 0 // header 없애기 - Custom Header
        
        cal.appearance.todaySelectionColor = .systemBlue //Today에 표시되는 선택 전 동그라미 색
        
        // 달에 유효하지않은 날짜 지우기
        cal.placeholderType = .none
        
        cal.appearance.titleFont = .systemFont(ofSize: 15)
        
        
        return cal
    }()
    /// MARK: calendar Header Label
    private lazy var calHeaderLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17, weight: .bold)
        view.textColor = TextColor.first.color
        view.text = "August 2023"

        return view
    }()
    /// MARK: 날짜 바꾸는 버튼
    private lazy var changeMonthButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.right")?.resize(newWidth: 14), for: .normal)
        return btn
    }()
    /// MARK: 전달로 이동하는 버튼
    private lazy var prevMonthButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.left")?.resize(newWidth: 20), for: .normal)
        return btn
    }()
    
    /// MARK: 다음달로 이동하는 버튼
    private lazy var nextMonthButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.right")?.resize(newWidth: 20), for: .normal)
        return btn
    }()
    
    
    
    
    private let viewModel = ScheduleViewModel()
    private let disposeBag = DisposeBag()
    
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        updateTitleView(title: "일정 관리")
        setupCustomBackButton()
        
        getData()
        addSubviews()
        configureConstraints()
        configureCollectionView()
        
        clickedButtons()
    }
    
    
    // MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backButtonTitle = ""
        navigationController?.toolbar.isHidden = true
        
        
    }
    
    /// MARK: Setting AutoLayout
    private func configureCollectionView(){
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.register(ScheduleFSCalendarCell.self, forCellReuseIdentifier: ScheduleFSCalendarCell.identifier)
        
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        
        
        containerView.addSubview(calHeaderLabel)
        containerView.addSubview(changeMonthButton)
        containerView.addSubview(prevMonthButton)
        containerView.addSubview(nextMonthButton)
        containerView.addSubview(calendarView)
    }
    private func configureConstraints(){
        
        // 스크롤 뷰
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        // 컨테이너 뷰
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        calHeaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        changeMonthButton.snp.makeConstraints { make in
            make.centerY.equalTo(calHeaderLabel.snp.centerY)
            make.leading.equalTo(calHeaderLabel.snp.trailing).offset(10)
        }
        prevMonthButton.snp.makeConstraints { make in
            make.centerY.equalTo(calHeaderLabel.snp.centerY)
            make.trailing.equalTo(nextMonthButton.snp.leading).offset(-20)
        }
        
        nextMonthButton.snp.makeConstraints { make in
            make.centerY.equalTo(calHeaderLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
            
        }
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(calHeaderLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(300)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    /// MARK: 버튼 클릭 시 실행
    private func clickedButtons(){
        nextMonthButton.rx.tap
            .bind {
                print("clicked nextMonthButton")
                self.scrollCurrentPage(isPrev: false)
            }
            .disposed(by: disposeBag)
        
        prevMonthButton.rx.tap
            .bind {
                print("clicked prevMonthButton")
                self.scrollCurrentPage(isPrev: true)
            }
            .disposed(by: disposeBag)
        
        changeMonthButton.rx.tap
            .bind {
                self.scrollCurrentPage(isPrev: false)
            }
            .disposed(by: disposeBag)
    }
    
    
    /// MARK: ViewModel에서 데이터 얻는 함수
    private func getData(){
        viewModel.getData()
    }
    
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()
        
    
    /// MARK: FSCalendar Header 년월 표시를 위한 Formatter, June 2023 형식
    private lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.dateFormat = "MMMM yyyy"
        return df
    }()
    /// MARK: tipView 년월 표시를 위한 Formatter, 2023.06 형식
    private lazy var dateFormatterAbbreviated: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.dateFormat = "yyyy.M"
        return df
    }()
    
    /// MARK : 달을 이동시키는 함수. isPrev가 1이면 전달로, 0이면 뒷달로 이동한다.
    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
            
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendarView.setCurrentPage(self.currentPage!, animated: true)
    }

}



extension MyPageMeetingDateViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance{
      
    
    // 화면 로딩됐을 때 현재 날짜에는 빨간색 원에 하얀색 글씨로 칠해두는 코드
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let dateMonth = Calendar.current.dateComponents([.month], from: date)
        let todayMonth = Calendar.current.dateComponents([.month], from: today)
        let dateDay = Calendar.current.dateComponents([.day], from: date)
        let todayDay = Calendar.current.dateComponents([.day], from: today)
        if dateMonth == todayMonth && dateDay == todayDay{
            return .white
        }else{
            return .black
        }
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let dateMonth = Calendar.current.dateComponents([.month], from: date)
        let todayMonth = Calendar.current.dateComponents([.month], from: today)
        let dateDay = Calendar.current.dateComponents([.day], from: date)
        let todayDay = Calendar.current.dateComponents([.day], from: today)
        if dateMonth == todayMonth && dateDay == todayDay{
            return .purple
        }else{
            return .none
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let cell = calendar.cell(for: date, at: monthPosition) else { return }
        cell.titleLabel.textColor = .white
        
        print(viewModel.formattingDate(date: date))
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        viewModel.getData()//ViewModel에서 데이터 얻는 함수
        
        //CustomHeader의 날짜 label을 바꾸는 과정
        self.calHeaderLabel.text = self.dateFormatter.string(from: calendar.currentPage)
    }

}




class CalenderDaysHeaderView: UIView {
    
    private var labelsText : [String] = ["일","월","화","수","목","금","토"]
    
    private lazy var Labels: [UILabel] = {
        let labels = [UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel()]
        for i in 0...6 {
            labels[i].text = labelsText[i]
            labels[i].font = UIFont.systemFont(ofSize: 15, weight: .regular)
        }
        return labels
    }()
    
    private lazy var btnsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: Labels)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .systemBackground
        return stack
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        self.addSubview(btnsStackView)
        btnsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class CustomCalenderHeaderView: UIView {
    
    
    private lazy var Label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var btnsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [Label])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .systemBackground
        return stack
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        self.addSubview(btnsStackView)
        btnsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
