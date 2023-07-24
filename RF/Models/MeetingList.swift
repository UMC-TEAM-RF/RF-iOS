//
//  MeetingList.swift
//  RF
//
//  Created by 정호진 on 2023/07/24.
//

import Foundation

/// MARK: 모임 목록 Model
struct MeetingList: Codable{
    let imageList: [String?]?
    let meetingTitle: String?
    let university: String?
    let country: String?
    let like: Bool?
}
