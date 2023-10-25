//
//  ScheduleService.swift
//  RF
//
//  Created by 정호진 on 10/25/23.
//

import Foundation
import Alamofire
import RxSwift

final class ScheduleService {
    
    func getMySchdule(year: Int, month: Int) -> Observable<[ScheduleList]> {
        var url = Domain.restApi + SchedulePath.myList
        let userId = UserDefaults.standard.string(forKey: "UserId") ?? ""
        url = url.replacingOccurrences(of: ":userId", with: userId)
        print(url)
        print(year)
        print(month)
        
        return Observable.create { observer in
            AF.request(url,
                       method: .get,
                       parameters:["year": year,
                                   "month": month])
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Response<[ScheduleList]>.self) { response in
                print(response)
                switch response.result {
                case .success(let data):
                    observer.onNext(data.result ?? [])
                case .failure(let error):
                    print("\(#function) error! \(error)")
                }
            }
            
            return Disposables.create()
        }
        
    }
    
}
