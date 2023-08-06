//
//  SignUpService.swift
//  RF
//
//  Created by 정호진 on 2023/08/04.
//

import Foundation
import RxSwift
import Alamofire

final class SignUpService {
    
    /// 아이디 중복 체크
    /// - Returns: Observable<Bool>
    func checkOverlapId(userId: String) -> Observable<Bool>{
        let url = "\(Bundle.main.REST_API_URL)/user/idCheck/\(userId)"
        
        return Observable.create { observer in
            
            AF.request(url,
                       method: .get)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: SignUpBase.self) { response in
                switch response.result{
                case .success(let data):
                    observer.onNext(data.result.judge ?? false)
                case .failure(let error):
                    print("checkOverlapId error!\n\(error)")
                }
            }
            
            return Disposables.create()
        }
    }
    
}
