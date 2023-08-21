//
//  DetailMeetingJoinService.swift
//  RF
//
//  Created by 정호진 on 2023/08/16.
//

import Foundation
import RxSwift
import Alamofire

final class DetailMeetingJoinService {
    
    /// 모임 가입 신청하기
    func sendingJoin(partyId: Int) -> Observable<Bool> {
        let url = "\(Domain.restApi)\(MeetingPath.requsetApply)"
        
        let body: [String: Any] = [
            "userId" : 1,
            "partyId": partyId
        ]
        
        return Observable.create { observer in
            
            AF.request(url,
                       method: .post,
                       parameters: body,
                       encoding: JSONEncoding.default)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Response<Judge>.self) { response in
                switch response.result{
                case .success(let data):
                    print("sendingJoin success!\n\(data)")
                    observer.onNext(data.isSuccess ?? false)
                case .failure(let error):
                    print("sendingJoin error!\n\(error)")
                }
            }
            
            return Disposables.create()
        }
    }
}
