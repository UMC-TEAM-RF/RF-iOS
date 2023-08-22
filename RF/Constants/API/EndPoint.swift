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
    static let meetingList = "/party/user/:userId/search"
    static let myMeetingList = "/party/user/:userId/belong"
    static let requsetApply = "/party/join/apply"
    static let recommendPersonalMeeting = "/party/user/:userId/recommend/personalParty"
    static let recommendGroupMeeting = "/party/user/:userId/recommend/groupParty"
}

/// Login EndPoint
struct LoginPath {
    static let login = "/user/login"
}

/// Report
struct ReportPath {
    static let reportParty = "/report/party"
}

/// Searching
struct SearchPath {
    static let search = "/party/search"
}
