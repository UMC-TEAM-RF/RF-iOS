//
//  Report.swift
//  RF
//
//  Created by 이정동 on 2023/08/22.
//

import Foundation


struct Report: Codable {
    let userId: Int
    let meetingId: Int
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "reporterId"
        case meetingId = "actorPartyId"
        case content
    }
}
