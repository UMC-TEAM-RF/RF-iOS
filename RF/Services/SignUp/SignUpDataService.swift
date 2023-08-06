//
//  PersonalInterestsService.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation
import RxSwift
import Alamofire

/// 회원가입 API 통신 Service
final class SignUpDataService {
    
    /// 유저 등록하는 함수
    func addUserInfo() -> Observable<Bool>{
        let url = "\(Bundle.main.REST_API_URL)/user"
        
        /// Dummy body
        let body: User = User(userID: "yxin", password: "12345678", university: "인하대학교", nickname: "인하대학교", phoneNumber: "010-1111-1111", interestLanguage: "영어", entrance: "2020", country: "대한민국", interestCountry: "캐나다", introduce: "코딩을하자", interest: ["게임", "음악"], mbti: "ISTP")
        
        return Observable.create { observer in
            
            AF.request(url,
                       method: .post,
                       parameters: body,
                       encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Welcome.self) { response in
                print("addUserInfo response\n\(response)")
                switch response.result{
                case .success(let data):
                    observer.onNext(data.isSuccess)
                case .failure(let error):
                    print("addUserInfo error! \n\(error)")
                }
            }
            
            return Disposables.create()
        }
    }
}
