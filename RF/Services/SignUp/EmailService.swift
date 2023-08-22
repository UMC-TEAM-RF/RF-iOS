//
//  EmailService.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation
import Alamofire
import RxSwift

/// 이메일 인증 하는 service
final class EmailService {
    
    /// 이메일로 인증번호 전송하는 함수
    func sendingEmail(email: String, university: String) -> Observable<Mail>{
        let url = "\(Domain.restApi)\(EmailPath.sendMail)"
        let body = Mail(mail: email, university: university, code: nil)
        print(body)
        return Observable.create { observer in
            AF.request(url,
                       method: .post,
                       parameters: body,
                       encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Response<Mail>.self) { response in
                print(response)
                switch response.result{
                case .success(let data):
                    if let data = data.result{
                        observer.onNext(data)
                    }
                case.failure(let error):
                    print("sendingEmail error!\n \(error)")
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    /// 인증번호 인증하는 함수
    func checkEmailCode(email: String, university: String, code: String) -> Observable<Bool>{
        let url = "\(Domain.restApi)\(EmailPath.checkCode)"
        let body = Mail(mail: email, university: university, code: code)
        
        return Observable.create { observer in
            AF.request(url,
                       method: .post,
                       parameters: body,
                       encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Response<Judge>.self) { response in
                switch response.result{
                case .success(let data):
                    
                    observer.onNext(data.isSuccess ?? false)
                case.failure(let error):
                    print("checkEmailCode error!\n \(error)")
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
