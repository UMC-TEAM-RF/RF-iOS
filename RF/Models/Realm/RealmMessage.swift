//
//  RealmMessage.swift
//  RF
//
//  Created by 이정동 on 2023/09/26.
//

import Foundation
import RealmSwift

class RealmMessage: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var speaker: RealmSender?
    @Persisted var type: String
    @Persisted var dateTime: String
    @Persisted var content: String?
    @Persisted var replyMessageId: Int?
    @Persisted var schedule: RealmSchedule?
    @Persisted var langCode: String?
    @Persisted var victim: RealmSender?
    @Persisted var isNew: Bool = true
    
    convenience init(id: Int,
                     speaker: RealmSender? = nil,
                     type: String,
                     dateTime: String,
                     content: String? = nil,
                     replyMessageId: Int? = nil,
                     schedule: RealmSchedule? = nil,
                     langCode: String? = nil,
                     victim: RealmSender? = nil
    ) {
        self.init()
        self.id = id
        self.speaker = speaker
        self.type = type
        self.dateTime = dateTime
        self.content = content
        self.replyMessageId = replyMessageId
        self.schedule = schedule
        self.langCode = langCode
        self.victim = victim
    }
}
