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
    
    /// MARK: 특정 날짜에 대한 리스트에 데이터 넣기
    func inputData(events: [ScheduleEvent]){
        specificEventList.accept(events)
    }
    
    /// MARK: specificEventList size
    func returnListSize() -> Int { return specificEventList.value.count }
}
