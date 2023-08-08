//
//  ChatDTO.swift
//  RF
//
//  Created by 이정동 on 2023/08/07.
//

import Foundation

// MARK: - 임시 타입

struct Message: Codable {
    var sender: MessageSender
    var sentDate: Date
    var content: String
    //var messageId: Int
}

struct MessageSender: Codable {
    var photoUrlString: String?
    var senderId: String
    var displayName: String
}

// MARK: - 사용

struct Channel {
    var id: Int   // 모임 ID
    var name: String   // 모임 이름
    var messages: [CustomMessage]
    var userProfileImages: [String]
    //var users: [User]
}

// MARK: - 실제 서버와 주고받을 데이터 타입으로 정의

struct CustomMessage: Codable {
    var id: Int?  // 메시지 ID
    var type: String?  // 메시지 타입 (TEXT, IMAGE, SCHEDULE)
    var content: String?  // 내용
    var dateTime: String?  // 보낸 시각
    var replyMessageId: Int?  // 답장할 메시지 ID
    var sender: CustomMessageSender?  // 보내는 사람
    var schedule: Schedule?
    
    var isNew: Bool = true  // 새 메시지 여부 (서버로부터 받을 때 기본 값으로 true 저장)
    
    enum CodingKeys: String, CodingKey {
        case content, type, dateTime, schedule
        case sender = "speaker"
        case replyMessageId = "replyChatId"
        case id = "chatId"
    }
}

struct CustomMessageSender: Codable {
    var id: Int?
    var displayName: String?
    var imageUrl: String?
    
    enum Codingkeys: String, CodingKey {
        case id = "speakerId"
        case displayName = "senderName"
        case imageUrl = "speakerImageUrl"
    }
}

struct Schedule: Codable {
    var id: Int?
    var name: String?
    var dateTime: String?
    var location: String?
    var participantCount: Int?
    var alert: Int?  // 몇 시간 전에 알림 올건지
    
    enum Codingkeys: String, CodingKey {
        case dateTime, location, participantCount, alert
        case id = "scheduleId"
        case name = "scheduleName"
    }
}

struct MessageType {
    static let text = "TEXT"
    static let image = "IMAGE"
    static let schedule = "SCHEDULE"
}
