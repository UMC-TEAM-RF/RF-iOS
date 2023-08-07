//
//  API.swift
//  RF
//
//  Created by 이정동 on 2023/08/07.
//

import Foundation

// STOMP API 주소
struct SocketAPI {
    static let connect = "/ws/websocket"
    static let subscribe = "/sub/channel"
    static let send = "/pub/redisChat"
}
