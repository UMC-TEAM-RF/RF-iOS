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
    static let subscribe = "/listen/chat"
    static let send = "/speak/chat"
}

/// Enum EndPoint
struct EnumPath {
    static let enums = "/enums"
}

// Naver Api EndPoint
struct PapagoApiPath {
    static let translation = "/v1/papago/n2mt"
    static let detectLangs = "/v1/papago/detectLangs"
}

/// SignUp EndPoint
struct SignUpPath {
    static let checkOverlapId = "/user/idCheck"
    static let checkOverlapNickName = "/user/nicknameCheck"
    static let addUser = "/user"
}

/// Email EndPoint
struct EmailPath {
    static let sendMail = "/mail/send"
    static let checkCode = "/mail/check"
}

/// Meeting EndPoint
struct MeetingPath {
    static let createMeeting = "/party"
    static let meetingList = "/party/non-blocked"
}

/// Login EndPoint
struct LoginPath {
    static let login = "/user/login"
}
