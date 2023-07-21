//
//  ScheduleFSCalendarCell.swift
//  RF
//
//  Created by 정호진 on 2023/07/21.
//

import UIKit
import SnapKit
import FSCalendar

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
    
    private var dayEventList: [ScheduleEvent] = []
    
    override init!(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        addSubviews()
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
    func inputData(events: [ScheduleEvent]){
        
        dayEventList = events
    }
    
}

extension ScheduleFSCalendarCell: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.identifier, for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
        
        cell.inputData(text: dayEventList[indexPath.row].description ?? "",
                       backgroundColor: .red)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return dayEventList.count }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return tableView.frame.height/4 }
}
