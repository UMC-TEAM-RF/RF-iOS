//
//  SearchService.swift
//  RF
//
//  Created by 정호진 on 2023/08/22.
//

import Foundation
import Alamofire
import RxSwift

final class SearchService {
    
    ///  검색 서비스
    func searchingService(name: String?, isRecruiting: Bool?, age: String?, num: Int?, interests: String?) -> Observable<MeetingList>{
        let userId = UserDefaults.standard.string(forKey: "UserId") ?? ""
        
        var url = "\(Domain.restApi)\(SearchPath.search)?userId=1"  // 테스트용
        
//        var url = "\(Domain.restApi)\(SearchPath.search)?userId=\(userId)"
        if let name = name {
            url.append("&name=\(name)")
        }
        
        if let isRecruiting = isRecruiting {
            url.append("&isRecruiting=\(isRecruiting)")
        }
        
        if let age = age {
            url.append("&preferAges=\(age)")
        }
        
        if let num = num {
            url.append("&partyMembersOption=\(num)")
        }
        
        if let interests = interests {
            url.append("&interests=\(interests)")
        }
        print("url \(url)")
        
        return Observable.create { observer in
            
            AF.request(url,
                       method: .get)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Response<MeetingList>.self) { response in
                print(response)
                switch response.result{
                case .success(let data):
                    if let data = data.result{
                        observer.onNext(data)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
}
