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
        
        let url = "\(Domain.restApi)\(LoginPath.login)"
        let body: [String: Any] = [
            SignInBody.first.body: id,
            SignInBody.second.body: pw,
            SignInBody.deviceToken.body: deviceToken
        ]
        
        print(body)
        return Observable.create { observer in
            AF.request(url,
                       method: .post,
                       parameters: body,
                       encoding: JSONEncoding.default)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Response<SignIn>.self) { response in
                switch response.result{
                case .success (let data):
                    if let data = data.result {
                        print("loginService success! \n\(data)")
                        observer.onNext(data)
                    }
                case .failure (let error):
                    print("loginService error!\n\(error)")
                }
            }
            
            return Disposables.create()
        }
    }
}
