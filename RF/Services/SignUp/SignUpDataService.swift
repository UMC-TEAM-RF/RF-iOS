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
        
        let body: User = User(userID: SignUpDataViewModel.viewModel.idRelay.value,
                              password: SignUpDataViewModel.viewModel.pwRelay.value,
                              university: SignUpDataViewModel.viewModel.universityRelay.value,
                              nickname: SignUpDataViewModel.viewModel.nickNameRelay.value,
                              interestLanguage: SignUpDataViewModel.viewModel.interestingLanguage.value,
                              entrance: SignUpDataViewModel.viewModel.yearRelay.value,
                              country: SignUpDataViewModel.viewModel.bornCountry.value,
                              interestCountry: SignUpDataViewModel.viewModel.interestingCountry.value,
                              introduce: SignUpDataViewModel.viewModel.introduceSelfRelay.value,
                              interest: SignUpDataViewModel.viewModel.interestingRelay.value,
                              mbti: SignUpDataViewModel.viewModel.mbtiRelay.value)
        
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
