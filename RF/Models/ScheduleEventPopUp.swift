//
//  SchedulePopUp.swift
//  RF
//
//  Created by 정호진 on 2023/07/29.
//

import Foundation

/// MARK: 특정 날짜 눌렀을 때 뜨는 팝업 이벤트 Model
struct ScheduleEventPopUp: Codable{
    let meetingNickname: String?
    let meetingName: String?
    let date: String?
    let time: String?
    let place: String?
    let peopleNum: String?
}
