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


