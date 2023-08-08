//
//  Meeting.swift
//  RF
//
//  Created by 이정동 on 2023/08/02.
//

import Foundation

struct MeetingData: Codable {
    var result: Meeting
}

struct MeetingListData: Codable {
    var result: [Meeting]
}

struct Meeting: Codable {
    var name: String?   // 모임 명
    var memberCount: Int?   // 모임 인원
    var nativeCount: Int?    // 자국인 멤버 수
    var interests: [String]? // 관심사
    var content: String?    // 소개글
    var rule: [String]?  // 규칙
    var preferAges: String? // 선호 연령대
    var language: String?   // 사용 언어
    var location: String?   // 활동 장소
    var tag: String?    // 태그
    var ownerId: Int?   // 모임 장
    var imageFilePath: String?  // 이미지 주소
}


