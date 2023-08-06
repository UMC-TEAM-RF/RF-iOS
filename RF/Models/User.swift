//
//  AddUserInfo.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation

struct User: Codable {
    let userID, password, university, nickname: String?
    let phoneNumber, interestLanguage, entrance, country: String?
    let interestCountry, introduce: String?
    let interest: [String]?
    let mbti: String?

    enum CodingKeys: String, CodingKey {
        case userID
        case password, university, nickname, phoneNumber, interestLanguage, entrance, country, interestCountry, introduce, interest, mbti
    }
}

struct Welcome: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
