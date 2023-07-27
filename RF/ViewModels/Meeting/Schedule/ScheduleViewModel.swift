//
//  ScheduleViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/07/21.
//

import Foundation
import RxSwift
import RxRelay

final class ScheduleViewModel {
    private let disposeBag = DisposeBag()
    
    /// 일정 리스트
    var eventList : BehaviorRelay<[ScheduleEvent]> = BehaviorRelay(value: [])
    
    /// MARK: Change Date -> String
    func formattingDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd E"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter.string(from: date)
    }
    
    /// 테스트 데이터 넣어 놓은 함수
    func getData() {
        var list: [ScheduleEvent] = []
        
        list.append(ScheduleEvent(date: "2023-07-09", description: "축구 경기",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-11", description: "스터디",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-01", description: "야구 경기",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-10", description: "마라탕 먹방",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-25", description: "마라탕 먹방",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-25", description: "마라탕 먹방",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-25", description: "마라탕 먹방",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-25", description: "마라탕 먹방",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-31", description: "집에 가기",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-31", description: "놀러 가기",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-31", description: "놀러 가기",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-31", description: "놀러 가기",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-07-31", description: "놀러 가기",color: "FE4700"))
        
        self.eventList.accept(list)
    }
    
    /// MARK: 날짜 변환 후 일정 리스트에 해당 날짜가 있는지 필터링
    func dateFiltering(date: Date) -> Observable<[ScheduleEvent]?>{
        let list = eventList.value
        
        let date = String(formattingDate(date: date).split(separator: " ")[0])
        let event = list.filter({ date == $0.date ?? "" })
        
        return Observable.create { observer in
            if event.isEmpty{
                observer.onNext([])
            }
            else{
                observer.onNext(event)
            }
            return Disposables.create()
        }
    }
    
}
