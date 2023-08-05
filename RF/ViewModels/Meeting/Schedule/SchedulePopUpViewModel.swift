//
//  SchedulePopUpViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/07/29.
//

import Foundation
import RxSwift
import RxRelay

final class SchedulePopUpViewModel {
    
    /// MARK: 선택한 날짜
    var selectedDate: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// MARK: 선택한 날짜 이벤트 정보
    var eventInformation: PublishRelay<ScheduleEventPopUp> = PublishRelay()
    
    func getData(){ 
        eventInformation.accept(ScheduleEventPopUp(meetingNickname: "마라미친자",
                                                   meetingName: "마라탕 먹는 모임",
                                                   date: "2023.07.25",
                                                   time: "15:00",
                                                   place: "마라마라",
                                                   peopleNum: "3명"))
    }
    
}
