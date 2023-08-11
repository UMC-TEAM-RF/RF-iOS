//
//  Papago.swift
//  RF
//
//  Created by 이정동 on 2023/08/11.
//

import Foundation

// 번역
struct TranslationData: Codable {
    let message: Translation
}

struct Translation: Codable {
    let result: TranslationResult
}

struct TranslationResult: Codable {
    let srcLangType, tarLangType, translatedText: String
}

// 언어 감지
struct Sensing: Codable {
    var langCode: String?
}
