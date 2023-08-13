//
//  ChatDTO.swift
//  RF
//
//  Created by 이정동 on 2023/08/07.
//

import Foundation

struct Channel {
    var id: Int   // 모임 ID
    var name: String   // 모임 이름
    var messages: [Message] = []
    var userProfileImages: [String]
    //var users: [User]
}

// MARK: - 실제 서버와 주고받을 데이터 타입으로 정의

struct Message: Codable {
    var id: Int?  // 메시지 ID
    var sender: Sender?  // 보내는 사람
    var type: String?  // 메시지 타입 (TEXT, IMAGE, SCHEDULE)
    var content: String?  // 내용
    var dateTime: String?  // 보낸 시각
    var replyMessageId: Int?  // 답장할 메시지 ID
    var schedule: Schedule?
    var langCode: String? // 언어 타입
    
    var isNew: Bool = true  // 새 메시지 여부 (서버로부터 받을 때 기본 값으로 true 저장)
    
    
    enum CodingKeys: String, CodingKey {
        case content, type, dateTime, schedule, langCode
        case sender = "speaker"
        case replyMessageId = "replyChatId"
        case id = "chatId"
    }
}

struct Sender: Codable {
    var userId: Int?
    var userName: String?
    var userImageUrl: String?
}

struct Schedule: Codable {
    var scheduleId: Int?
    var scheduleName: String?
    var dateTime: String?
    var location: String?
    var participantCount: Int?
    var alert: Int?  // 몇 시간 전에 알림 올건지
}

struct MessageType {
    static let text = "TEXT"
    static let image = "IMAGE"
    static let schedule = "SCHEDULE"
}
