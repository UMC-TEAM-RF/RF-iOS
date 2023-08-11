//
//  API.swift
//  RF
//
//  Created by 이정동 on 2023/08/07.
//

import Foundation

// Socket EndPoint
struct SocketPath {
    static let connect = "/ws/websocket"
    static let subscribe = "/sub/channel"
    static let send = "/pub/redisChat"
}

// Naver Api EndPoint
struct NaverApiPath {
    static let papago = "/v1/papago/n2mt"
}
