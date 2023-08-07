//
//  Response.swift
//  RF
//
//  Created by 이정동 on 2023/08/07.
//

import Foundation

struct Response<T: Codable>: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: T?
}


// MARK: - 이후에 지워주세요
struct ResponseData: Codable {
    var isSuccess: Bool?
    var code: Int?
    var message: String?
}


