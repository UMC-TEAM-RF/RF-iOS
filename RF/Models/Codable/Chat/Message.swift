//
//  ChatDTO.swift
//  RF
//
//  Created by 이정동 on 2023/08/07.
//

import Foundation

struct Message: Codable {
    var id: Int?  // 메시지 ID
    var sender: Sender?  // 보내는 사람
    var type: String?  // 메시지 타입 (TEXT, IMAGE, SCHEDULE, ...)
    var content: String?  // 내용
    var dateTime: String?  // 보낸 시각
    var replyMessageId: Int?  // 답장할 메시지 ID
    var schedule: Schedule?
    var langCode: String? // 언어 타입
    var partyName: String? // 그룹 이름
    var partyId: Int?
    var victim: Sender?
    
    var isNew: Bool = true  // 새 메시지 여부 (서버로부터 받을 때 기본 값으로 true 저장)
    
    enum CodingKeys: String, CodingKey {
        case content, type, dateTime, schedule, langCode, partyName, partyId, victim
        case sender = "speaker"
        case replyMessageId = "replyChatId"
        case id = "chatId"
    }
}

// ChatMessageType 정의
struct MessageType {
    static let text = "TEXT"
    static let image = "IMAGE"
    static let schedule = "SCHEDULE"
    static let reply = "REPLY"
    static let invite = "INVITE"
    static let leave = "LEAVE"
    static let kickOut = "KICT_OUT"
}

extension Message {
    func toRealmObject() -> RealmMessage {
        let realmSender = sender?.toRealmObject()
        let realmVictim = victim?.toRealmObject()
        let realmSchedule = schedule?.toRealmObject()
        
        return RealmMessage(
            id: self.id!,
            speaker: realmSender,
            type: self.type!,
            dateTime: self.dateTime!,
            content: self.content,
            replyMessageId: self.replyMessageId,
            schedule: realmSchedule,
            langCode: self.langCode,
            victim: realmVictim
        )
    }
}

