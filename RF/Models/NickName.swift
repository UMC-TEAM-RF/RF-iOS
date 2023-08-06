//
//  NickName.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation

struct NickNameBase: Codable{
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: NickName
}


struct NickName: Codable{
    let judge: Bool?
}
