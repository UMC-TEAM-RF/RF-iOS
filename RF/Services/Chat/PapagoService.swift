//
//  PapagoService.swift
//  RF
//
//  Created by 이정동 on 10/10/23.
//

import Foundation
import Alamofire

class PapagoService {
    static let shared = PapagoService()
    private init() {}
    
    /// 언어 번역
    /// - Parameters:
    ///   - source: 원본 언어
    ///   - target: 목적 언어
    ///   - text: 번역할 텍스트
    ///   - completion: 번역 결과
    func translateMessage(source: String, target: String, text: String, completion: @escaping (String)->()) {
        
        let url = "\(Domain.naverApi)\(PapagoApiPath.translation)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Naver-Client-Id": NaverApiHeaders.clientId,
            "X-Naver-Client-Secret": NaverApiHeaders.clientSecret
        ]
        let params: [String: Any] = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: TranslationData.self) { response in
                switch response.result{
                case .success (let data):
                    completion(data.message.result.translatedText)
                case .failure (let error):
                    print("Translate error!\n\(error)")
                }
            }
    }
    
    /// 언어 탐지
    /// - Parameters:
    ///   - text: 탐지할 언어
    ///   - completion: 탐지된 언어 코드
    func detectLanguage(_ text: String, completion: @escaping (String)->()) {
        let url = "\(Domain.naverApi)\(PapagoApiPath.detectLangs)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Naver-Client-Id": NaverApiHeaders.clientId,
            "X-Naver-Client-Secret": NaverApiHeaders.clientSecret
        ]
        
        let params: [String: Any] = [
            "query": text
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Sensing.self) { response in
                switch response.result{
                case .success (let data):
                    completion(data.langCode)
                case .failure (let error):
                    print("Translate error!\n\(error)")
                }
            }
    }
}
