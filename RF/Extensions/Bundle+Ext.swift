//
//  Bundle+Ext.swift
//  RF
//
//  Created by 이정동 on 2023/08/02.
//

import Foundation

extension Bundle {
    
    var REST_API_URL: String {
        return getSecretKey(key: "REST_API_URL")
    }
    
    var WEB_SOCKET_URL: String {
        return getSecretKey(key: "WEB_SOCKET_URL")
    }
    
    var NAVER_CLIENT_SECRET: String {
        return getSecretKey(key: "NAVER_CLIENT_SECRET")
    }
    
    var NAVER_CLIENT_ID: String {
        return getSecretKey(key: "NAVER_CLIENT_ID")
    }
    
    var NAVER_API_URL: String {
        return getSecretKey(key: "NAVER_API_URL")
    }
    
    // SecretKey.plist에서 값 가져오기
    /// - parameter key: SecretKey.plist에 등록된 Key
    /// - returns: Key에 해당하는 Value
    private func getSecretKey(key: String) -> String {
        guard let file = self.path(forResource: "SecretKey", ofType: "plist") else { return "" }
        
        // .plist를 딕셔너리로 받아오기
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        // 딕셔너리에서 값 찾기
        guard let key = resource[key] as? String else {
            fatalError("\(key) error")
        }
        return key
    }
}
