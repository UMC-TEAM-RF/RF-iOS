//
//  AddUserInfo.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation

struct User: Codable {
    let loginId, password, university, nickname: String?
    let email, lifeStyle: String?
    let entrance: Int?
    let country: String?
    let introduce: String?
    let interestLanguage, interestCountry, interest: [String]?
    let mbti: String?
    let profileImageUrl: String?
    let userId: Int?
    
    enum CodingKeys: String, CodingKey {
        case loginId
        case nickname = "nickName"
        case interestLanguage = "interestingLanguages"
        case interestCountry = "interestCountries"
        case password, university, entrance, country
        case introduce, email, lifeStyle
        case interest = "interests"
        case mbti, profileImageUrl, userId
    }
}

