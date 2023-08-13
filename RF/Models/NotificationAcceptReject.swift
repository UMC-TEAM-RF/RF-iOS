//
//  NotificationAcceptReject.swift
//  RF
//
//  Created by 정호진 on 2023/08/13.
//

import Foundation

/// 거절 수락 화면 (임시용 모델)
struct NotificationAcceptReject: Codable {
    let profileImage: String?
    let joinedGroup: String?
    let country: String?
    let mbti: String?
}
