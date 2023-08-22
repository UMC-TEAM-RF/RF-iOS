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
    
    /// MARK: Change Date -> String
    func formattingDate_HeaderView(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter.string(from: date)
    }
    
    /// 테스트 데이터 넣어 놓은 함수
    func getData() {
        var list: [ScheduleEvent] = []
        
        list.append(ScheduleEvent(date: "2023-08-23", description: "데모 데이",color: "00f44d"))
        list.append(ScheduleEvent(date: "2023-08-24", description: "데모 데이",color: "00f44d"))
        list.append(ScheduleEvent(date: "2023-08-15", description: "광복절",color: "FE4700"))
        list.append(ScheduleEvent(date: "2023-08-11", description: "알프 모임",color: "00daf7"))
        list.append(ScheduleEvent(date: "2023-07-25", description: "마라탕 먹방",color: "f1f900"))
        list.append(ScheduleEvent(date: "2023-09-01", description: "개강 파티",color: "1dfc00"))
        
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
