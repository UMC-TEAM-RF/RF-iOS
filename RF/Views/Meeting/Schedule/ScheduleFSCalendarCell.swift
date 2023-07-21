//
//  ScheduleFSCalendarCell.swift
//  RF
//
//  Created by 정호진 on 2023/07/21.
//

import UIKit
import SnapKit
import FSCalendar
import RxSwift

final class ScheduleFSCalendarCell: FSCalendarCell {
    static let identifier = "ScheduleFSCalendarCell"
    
    /// MARK: Subtitle Custom Label
    private lazy var subtitleTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.isScrollEnabled = false
        table.isUserInteractionEnabled = false
        table.separatorStyle = .none
        return table
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = ScheduleFSCalendarCellViewModel()
    
    override init!(frame: CGRect) {
        super.init(frame: frame)
//        addSubviews()
    }
    
    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
//        addSubviews()
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        addSubview(subtitleTableView)
        
        subtitleTableView.delegate = self
        subtitleTableView.dataSource = self
        subtitleTableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.identifier)
        
        configureConstraints()
    }
    
    /// MARK: Setting AutoLayout
    private func configureConstraints(){
        subtitleTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    /// MARK: 일정을 넣는 함수
    func inputData(events: [ScheduleEvent]?){
        addSubviews()
        guard let events = events else { return }
        viewModel.inputData(events: events)
    }
    
}

extension ScheduleFSCalendarCell: UITableViewDelegate, UITableViewDataSource{ 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.identifier, for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
        
        viewModel.specificEventList
            .bind { events in

                if !events.isEmpty && indexPath.row < events.count{
                    cell.inputData(text: events[indexPath.row].description ?? "",
                                   backgroundColor: .red)
                }
                else{
                    cell.inputData(text: "",
                                   backgroundColor: .clear)
                }
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return viewModel.returnListSize() }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return tableView.frame.height/4 }
}
