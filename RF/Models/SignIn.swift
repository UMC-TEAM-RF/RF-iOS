//
//  SignIn.swift
//  RF
//
//  Created by 정호진 on 2023/07/31.
//

import Foundation

/// MARK: 로그인 모델
struct SignIn: Codable{
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: SignInResult
    
    enum CoingKeys: String, CodingKey{
        case isSuccess
        case code
        case message
        case result
    }
}

struct SignInResult: Codable{
    let id: Int?
    let token: String?
    
    enum CoingKeys: String, CodingKey{
        case id
        case token
    }
}

/// MARK: 로그인 할때 사용하는 Body parameters
enum SignInBody{
    case first, second
    
    var body: String{
        switch self{
        case .first:
            return "loginId"
        case .second:
            return "password"
        }
    }
}
