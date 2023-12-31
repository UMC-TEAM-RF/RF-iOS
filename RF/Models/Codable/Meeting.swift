//
//  Meeting.swift
//  RF
//
//  Created by 이정동 on 2023/08/02.
//

import Foundation

struct Page: Codable {
    let currentPage: Int?
    let totalPage: Int?
    let content: [Meeting]?
}

struct Meeting: Codable {
    var id: Int?    // 모임 id
    var name: String?   // 모임 명
    var memberCount: Int?   // 모임 인원
    var nativeCount: Int?    // 자국인 멤버 수
    var interests: [String]? // 관심사
    var content: String?    // 소개글
    var rules: [String]?  // 규칙
    var preferAges: String? // 선호 연령대
    var isRecruiting: Bool? // 모집중 확인
    var language: String?   // 사용 언어
    var location: String?   // 활동 장소
    var ownerId: Int?   // 모임 장
    var imageFilePath: String?  // 이미지 주소
    var users: [User]?
    var currentMemberCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case users = "userProfiles"
        case id, name, memberCount, nativeCount, interests, content, rules
        case preferAges, isRecruiting, language, location, ownerId, imageFilePath, currentMemberCount
    }
}


struct MeetingList: Codable {
    let currentPage: Int?
    let totalPage: Int?
    let content: [Meeting]?
}
