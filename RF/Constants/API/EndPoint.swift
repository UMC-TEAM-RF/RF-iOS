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
    static let checkOverlapId = "/user/idCheck"
    static let checkOverlapNickName = "/user/nicknameCheck"
    static let addUser = "/user"
    static let sendMail = "/mail/send"
    static let checkCode = "/mail/check"
    static let createMeeting = "/party"
    static let meetingList = "/party/non-blocked"
    static let login = "/signin"
    static let enums = "/enums"
}

// Naver Api EndPoint
struct PapagoApiPath {
    static let translation = "/v1/papago/n2mt"
    static let detectLangs = "/v1/papago/detectLangs"
}
