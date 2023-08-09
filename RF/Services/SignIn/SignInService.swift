//
//  SignInService.swift
//  RF
//
//  Created by 정호진 on 2023/07/31.
//

import Foundation
import Alamofire
import RxSwift

final class SignInService {
    
    /// MARK: 로그인 성공 후 SignIn 모델 반환
    /// - Returns: SignIn Decoding Values
    func loginService(id: String, pw: String, deviceToken: String) -> Observable<SignIn>{
        
        let url = "\(Bundle.main.REST_API_URL)/signin"
//        let body: [String: Any] = [
//            SignInBody.first.body: id,
//            SignInBody.second.body: pw
//        ]
        
        let body: [String: Any] = [
            "loginId" : id,
            "password" : pw,
            "deviceToken" : deviceToken
        ]
        print(body)
        return Observable.create { observer in
            AF.request(url,
                       method: .post,
                       parameters: body,
                       encoding: JSONEncoding.default)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: SignIn.self) { response in
                print(response)
                switch response.result{
                case .success (let data):
                    observer.onNext(data)
                case .failure (let error):
                    print("loginService error!\n\(error)")
                }
            }
            
            return Disposables.create()
        }
    }
}
