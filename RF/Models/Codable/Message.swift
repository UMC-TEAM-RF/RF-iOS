//
//  ChatDTO.swift
//  RF
//
//  Created by 이정동 on 2023/08/07.
//

import Foundation

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
