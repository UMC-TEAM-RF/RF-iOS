//
//  Schedule.swift
//  RF
//
//  Created by 이정동 on 2023/09/26.
//

import Foundation

struct Schedule: Codable {
    var scheduleId: Int?
    var scheduleName: String?
    var dateTime: String?
    var location: String?
    var participantCount: Int? = 0
    var alert: Int? = 0 // 몇 시간 전에 알림 올건지
}

extension Schedule {
    func toRealmObject() -> RealmSchedule {
        return RealmSchedule(
            id: self.scheduleId!,
            name: self.scheduleName!,
            dateTime: self.dateTime!,
            location: self.location!,
            participantCount: self.participantCount!
        )
    }
}
