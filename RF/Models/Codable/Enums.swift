//
//  Enums.swift
//  RF
//
//  Created by 정호진 on 2023/08/08.
//

import Foundation

final class EnumFile {
    static let enumfile = EnumFile()
    private init() {}
    
    var list: Enums?
    
}

struct Enums: Codable {
    var country, interest, language, lifeStyle: [KVO]?
    var mbti, preferAges, rule, university: [KVO]?

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case interest = "Interest"
        case language = "Language"
        case lifeStyle = "LifeStyle"
        case mbti = "Mbti"
        case preferAges = "PreferAges"
        case rule = "Rule"
        case university = "University"
    }
}

struct KVO: Codable {
    var key, value: String?
}
