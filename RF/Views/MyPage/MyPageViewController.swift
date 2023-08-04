//
//  MeetingViewController.swift
//  RF
//
//  Created by 용용이 on 2023/07/27.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift
import FSCalendar

class MyPageViewController: UIViewController {
    
    /// MARK: 스크롤 가능한 화면을 만들기 위해 스크롤뷰와 컨테이너뷰 정의하기
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    
    /// MARK: 모임 제목 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "마이페이지"
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
        btn.setImage(UIImage(systemName: "gearshape")?.resize(newWidth: 25).rotate(degrees: 0), for: .normal)
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
    
    
    /// MARK: 프로필 이미지
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "LogoImage")
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        view.layer.cornerRadius = view.bounds.width / 2
        return view
    }()
    
    
    
    
    /// MARK:
    private lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.text = "KPOP 매니아 | 소융대 🇰🇷"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    /// MARK: 모임 찾기 버튼
    private lazy var profileMoreButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.down")?.resize(newWidth: 14), for: .normal)
        return btn
    }()
    
    /// MARK: 한 줄 소개
    private lazy var introduceLabel: UILabel = {
        let label = UILabel()
        label.text = "행복한 하루를 보내고 싶어요! (한 줄 소개)"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    /// MARK: 한 줄 소개 수정버튼
    private lazy var introduceChangeButton: UIButton = {
        let btn = UIButton()
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.black.cgColor
        btn.titleLabel?.text = "수정"
        btn.setTitle("수정", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 8)
        return btn
    }()
    
    

    /// MARK: 알프 온도 Title
    private lazy var temperTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "알프 온도"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    /// MARK: 알프 온도 아이콘
    private lazy var temperImojiView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "smile")?.resize(newWidth: 20)
        return view
    }()
    /// MARK: 알프 온도 Message
    private lazy var temperMessageLabel: UILabel = {
        let label = UILabel()
        label.text = temperMessage
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    /// MARK: 알프 온도 Message
    private lazy var temperNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "\(temper)도"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    /// MARK: 알프 온도 프로그레스 바
    /// 최저 : 0도, 최고 : 70도(maxTemperature 변수)
    private lazy var temperProgressBar: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.backgroundColor = UIColor(hexCode: "D1D1D1")
        pv.progress = Float((temper / maxTemperature))
        pv.layer.cornerRadius = 10
        return pv
    }()
    
    private var temperMessageList = ["심성이 따뜻하네요","활동적이고 따뜻함이 느껴져요", "뜨거운 열정과 심성을 가진 알프레드님🔥","모두가 인정한 열정맨! 플러스 친절함까지?"]
    private var temper = 37.2
    private let maxTemperature = 70.0
    private var temperMessage : String {
        get{
            if(temper > 36.5 && temper <= 40){
                return temperMessageList[0]
            }
            else if(temper > 40 && temper <= 50){
                return temperMessageList[1]
            }
            else if(temper > 50 && temper <= 60){
                return temperMessageList[2]
            }
            else if(temper > 60 && temper <= 70){
                return temperMessageList[3]
            }else{
                return "온도가 범위를 벗어났습니다. 관리자에게 문의하세요."
            }
                
        }
    }
    
    private var meetingTipMessageList = ["이번 달의 모임 횟수는 미미하네요! 모임을 즐겨 보세요!", "모임을 즐겨하시네요! 알프를 통해 더 많이 활용해보세요 :-)", "모임 매니아시군요! 진정한 인싸는 바로 OO님!"]
    private let meetingperMonth = 3
    private var meetingTipMessage : String {
        get{
            if(meetingperMonth >= 0 && meetingperMonth < 5){
                return temperMessageList[0]
            }else if(meetingperMonth >= 5 && meetingperMonth < 10){
                return temperMessageList[1]
            }else{
                return temperMessageList[2]
            }
                
        }
    }
    
    
    /// MARK: tipView
    private lazy var tipBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .systemGray6
        return view
    }()
    /// MARK: tipView Title
    private lazy var tipTitleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textColor = .black
        view.text = "2023.06"
        
        return view
    }()
    /// MARK: tipView Title Button
    private lazy var tipDateChangeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.right")?.resize(newWidth: 10), for: .normal)
        btn.imageView?.tintColor = .systemBlue
        return btn
    }()
    /// MARK: tipView Text
    private lazy var tipTextLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textColor = .black
        view.numberOfLines = 2
        view.text = meetingTipMessage
        
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
        
        cal.appearance.weekdayTextColor = .systemGray4
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
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textColor = .black
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
        
        getData()
        addSubviews()
        clickedButtons()
    }
    
    // MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = ""
        navigationController?.toolbar.isHidden = true
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(btnsStackView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(profileLabel)
        containerView.addSubview(profileMoreButton)
        containerView.addSubview(introduceLabel)
        containerView.addSubview(introduceChangeButton)
        
        
        containerView.addSubview(temperTitleLabel)
        containerView.addSubview(temperImojiView)
        containerView.addSubview(temperMessageLabel)
        containerView.addSubview(temperNumberLabel)
        containerView.addSubview(temperProgressBar)
        
        containerView.addSubview(tipBackgroundView)
        tipBackgroundView.addSubview(tipTitleLabel)
        tipBackgroundView.addSubview(tipDateChangeButton)
        tipBackgroundView.addSubview(tipTextLabel)
        
        
        
        containerView.addSubview(calHeaderLabel)
        containerView.addSubview(changeMonthButton)
        containerView.addSubview(prevMonthButton)
        containerView.addSubview(nextMonthButton)
        containerView.addSubview(calendarView)
        
        
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.register(ScheduleFSCalendarCell.self, forCellReuseIdentifier: ScheduleFSCalendarCell.identifier)
        
        configureConstraints()
    }
    
    /// MARK: Setting AutoLayout
    private func configureConstraints(){
        
        // 스크롤 뷰
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).offset(5)
        }
        // 컨테이너 뷰
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        
    
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        btnsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalTo(titleLabel.snp.bottom)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
        }
        
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        profileMoreButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.equalTo(profileLabel.snp.trailing).offset(10)
        }
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        introduceChangeButton.snp.makeConstraints { make in
            make.centerY.equalTo(introduceLabel.snp.centerY)
            make.leading.equalTo(introduceLabel.snp.trailing).offset(10)
        }
        
        
        temperTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
        }
        temperImojiView.snp.makeConstraints { make in
            make.top.equalTo(temperTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(temperTitleLabel.snp.leading)
        }
        temperMessageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(temperImojiView.snp.centerY)
            make.leading.equalTo(temperImojiView.snp.trailing).offset(10)
        }
        temperNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(temperImojiView.snp.centerY)
            make.trailing.equalToSuperview().inset(30)
        }
        temperProgressBar.snp.makeConstraints { make in
            make.top.equalTo(temperMessageLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(6)
        }
        
        
        
        tipBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(temperProgressBar.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        tipTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
        }
        tipDateChangeButton.snp.makeConstraints { make in
            make.centerY.equalTo(tipTitleLabel.snp.centerY)
            make.leading.equalTo(tipTitleLabel.snp.trailing).offset(8)
        }
        tipTextLabel.snp.makeConstraints { make in
            make.top.equalTo(tipTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(tipTitleLabel.snp.trailing).offset(8)
            make.bottom.equalToSuperview().inset(20)
        }
        
        
        
        
        
        calHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(tipBackgroundView.snp.bottom).offset(20)
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
    
    /// MARK: ViewModel에서 데이터 얻는 함수
    private func getData(){
        viewModel.getData()
    }


}

extension MyPageViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance{
      
    /// 선택했을 때 색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return .systemBlue
        }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return .white
    }
    
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
    
    /// cell의 default color 변경
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let dateMonth = Calendar.current.dateComponents([.month], from: date)
        let todayMonth = Calendar.current.dateComponents([.month], from: today)
        let dateDay = Calendar.current.dateComponents([.day], from: date)
        let todayDay = Calendar.current.dateComponents([.day], from: today)
        if dateMonth == todayMonth && dateDay == todayDay{
            return .red
        }else{
            return .none
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let cell = calendar.cell(for: date, at: monthPosition) else { return }
        cell.titleLabel.textColor = .black
        
        print(viewModel.formattingDate(date: date))
    }
    
//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//        guard let cell = calendar.dequeueReusableCell(withIdentifier: ScheduleFSCalendarCell.identifier, for: date, at: position) as? ScheduleFSCalendarCell else { return FSCalendarCell()}
//
//        viewModel.dateFiltering(date: date)
//            .subscribe(onNext:{ list in
//                cell.inputData(events: list)
//            })
//            .disposed(by: disposeBag)
//
//        return cell
//    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        viewModel.getData()//ViewModel에서 데이터 얻는 함수
        
        //CustomHeader의 날짜 label을 바꾸는 과정
        self.calHeaderLabel.text = self.dateFormatter.string(from: calendar.currentPage)
        self.tipTitleLabel.text = self.dateFormatterAbbreviated.string(from: calendar.currentPage)
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
