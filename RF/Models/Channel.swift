//
//  Channel.swift
//  RF
//
//  Created by 이정동 on 2023/09/26.
//

import Foundation

struct Channel {
    var id: Int   // 모임 ID
    var name: String   // 모임 이름
    var messages: [Message] = []
    var userProfileImages: [String]
    //var users: [User]
}
