//
//  SignIn.swift
//  RF
//
//  Created by 정호진 on 2023/07/31.
//

import Foundation

/// 로그인 모델
struct SignIn: Codable{
    let accessToken: String?
    let refreshToken: String?
    let user: User?
    
    enum CoingKeys: String, CodingKey{
        case accessToken
        case refreshToken
        case user
    }
}

/// MARK: 로그인 할때 사용하는 Body parameters
enum SignInBody{
    case first, second, deviceToken
    
    var body: String{
        switch self{
        case .first:
            return "loginId"
        case .second:
            return "password"
        case .deviceToken:
            return "deviceToken"
        }
    }
}
