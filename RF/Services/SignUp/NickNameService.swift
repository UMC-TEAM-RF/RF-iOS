//
//  NickNameService.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation
import Alamofire
import RxSwift

final class NickNameService {
    
    /// 닉네임 중복 확인하는 함수
    func checkOverlapNickName(name: String) -> Observable<Bool> {
        let url = "\(Bundle.main.REST_API_URL)/user/nicknameCheck/\(name)"
        
        return Observable.create { observer in
            AF.request(url,
                       method: .get)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: NickNameBase.self) { response in
                switch response.result{
                case .success(let data):
                    observer.onNext(data.result.judge ?? false)
                case .failure(let error):
                    print("checkOverlapNickName error! \(error)")
                }
            }
            return Disposables.create()
        }
    }
}
