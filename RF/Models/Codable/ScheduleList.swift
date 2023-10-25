//
//  Schedule.swift
//  RF
//
//  Created by 정호진 on 10/25/23.
//

import Foundation

struct ScheduleList: Codable {
    let id: Int?
    let partyId: Int?
    let partyName: String?
    let scheduleName: String?
    let localDateTime: String?
    let location: String?
    let participantCount: Int?
}
