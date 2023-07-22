//
//  ScheduleFSCalendarCellViewMdoel.swift
//  RF
//
//  Created by 정호진 on 2023/07/21.
//

import Foundation
import RxRelay
import RxSwift

final class ScheduleFSCalendarCellViewModel {
    /// 특정 날짜에 대한 일정 리스트
    var specificEventList : BehaviorRelay<[ScheduleEvent]> = BehaviorRelay(value: [])
    
    /// 테이블 뷰가 생성 되었는지 
    var isTableView: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    /// MARK: 특정 날짜에 대한 리스트에 데이터 넣기
    func inputData(events: [ScheduleEvent]){
        specificEventList.accept(events)
    }
    
    /// MARK: 테이블 뷰를 만들었다고 하는 것
    func isTableViewToTrue(){
        isTableView.accept(true)
    }
    
    /// MARK: specificEventList size
    func returnListSize() -> Int { return specificEventList.value.count }
}
