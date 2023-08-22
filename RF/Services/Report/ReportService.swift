//
//  ReportService.swift
//  RF
//
//  Created by 이정동 on 2023/08/22.
//

import Foundation
import Alamofire
import RxSwift

final class ReportService {
    
    func reportParty(_ report: Report) -> Observable<Bool> {
        let url = "\(Domain.restApi)\(ReportPath.reportParty)"
        
        return Observable.create { observer in
            
            AF.request(url,
                       method: .post,
                       parameters: report,
                       encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Response<Judge>.self) { response in
                switch response.result{
                case .success(let data):
                    print("report success!\n\(data)")
                    observer.onNext(data.isSuccess ?? false)
                case .failure(let error):
                    observer.onError(error)
                    print("report error!\n\(error)")
                }
            }
            
            return Disposables.create()
        }
    }
}
