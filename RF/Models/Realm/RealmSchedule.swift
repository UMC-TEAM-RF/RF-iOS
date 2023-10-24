//
//  RealmSchedule.swift
//  RF
//
//  Created by 이정동 on 2023/09/26.
//

import Foundation
import RealmSwift

class RealmSchedule: Object {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var dateTime: String
    @Persisted var location: String
    @Persisted var participantCount: Int
    
    convenience init(id: Int, name: String, dateTime: String, location: String, participantCount: Int) {
        self.init()
        self.id = id
        self.name = name
        self.dateTime = dateTime
        self.location = location
        self.participantCount = participantCount
    }
}
