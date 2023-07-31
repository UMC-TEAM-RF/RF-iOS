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
    func loginService(id: String, pw: String) -> Observable<SignIn>{
        let url = APIURL.api.loginURL()
        let body: Parameters = [
            "loginId": id,
            "userId": pw
        ]
        
        return Observable.create { observer in
            AF.request(url,
                       method: .post,
                       parameters: body)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: SignIn.self) { response in
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
