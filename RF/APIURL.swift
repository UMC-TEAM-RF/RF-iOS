//
//  APIURL.swift
//  RF
//
//  Created by 정호진 on 2023/07/31.
//

import Foundation

final class APIURL {
    /// 임시 변수 ip, port
    static let ip: String = "ip 주소 넣으면 됨"
    static let port: Int = 0
    
    static let api = APIURL()
    private init() {}
    
    /// 로그인 URL
    func loginURL() -> String{
        let url = "http://\(APIURL.ip):\(APIURL.port)/sign-in"
        return url
    }
}
