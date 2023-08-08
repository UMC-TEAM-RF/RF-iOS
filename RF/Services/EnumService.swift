//
//  EnumService.swift
//  RF
//
//  Created by 정호진 on 2023/08/08.
//

import Foundation
import RxSwift
import Alamofire

final class EnumService {
    
    /// 초기 데이터 리스트 받는 함수
    func getEnumList() -> Observable<Enums>{
        let url = "\(Bundle.main.REST_API_URL)/enums"
        
        return Observable.create{ observer in
            AF.request(url,
                       method: .get)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Enums.self) { response in
                switch response.result{
                case .success(let data):
                    observer.onNext(data)
                case .failure(let error):
                    print("getEnumList error! \(error)")
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    
}
