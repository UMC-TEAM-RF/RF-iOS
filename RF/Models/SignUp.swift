//
//  SignUp.swift
//  RF
//
//  Created by 정호진 on 2023/08/04.
//

import Foundation

struct SignUpBase: Codable{
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: SignUp
}


struct SignUp: Codable{
    let judge: Bool?
}
