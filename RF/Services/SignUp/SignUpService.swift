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
            .responseDecodable(of: Response<String>.self) { response in
                switch response.result{
                case .success(let data):
                    print("checkOverlapId success \(data)")
                    observer.onNext(data.isSuccess ?? false)
                case .failure(let error):
                    print("checkOverlapId error!\n\(error)")
                }
            }
            
            return Disposables.create()
        }
    }
    
    /// 닉네임 중복 확인하는 함수
    func checkOverlapNickName(name: String) -> Observable<Bool> {
        let url = "\(Bundle.main.REST_API_URL)/user/nicknameCheck/\(name)"
        
        return Observable.create { observer in
            AF.request(url,
                       method: .get)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Response<String>.self) { response in
                print(response)
                switch response.result{
                case .success(let data):
                    observer.onNext(data.isSuccess ?? false)
                case .failure(let error):
                    print("checkOverlapNickName error! \(error)")
                }
            }
            return Disposables.create()
        }
    }
    
    
    /// 유저 등록하는 함수
    func addUserInfo() -> Observable<Bool>{
        let url = "\(Bundle.main.REST_API_URL)/user"
        let interestLanguage = SignUpDataViewModel.viewModel.interestingLanguage.value.map({"\($0.key ?? "")"})
        
        let body: User = User(userID: SignUpDataViewModel.viewModel.idRelay.value,
                              password: SignUpDataViewModel.viewModel.pwRelay.value,
                              university: SignUpDataViewModel.viewModel.universityRelay.value,
                              nickname: SignUpDataViewModel.viewModel.nickNameRelay.value,
                              entrance: SignUpDataViewModel.viewModel.yearRelay.value,
                              country: SignUpDataViewModel.viewModel.bornCountry.value,
                              introduce: SignUpDataViewModel.viewModel.introduceSelfRelay.value,
                              interestLanguage: SignUpDataViewModel.viewModel.interestingLanguage.value.map({"\($0.key ?? "")"}),
                              interestCountry: SignUpDataViewModel.viewModel.interestingCountry.value.map({"\($0.key ?? "")"}),
                              interest: SignUpDataViewModel.viewModel.interestingRelay.value,
                              mbti: SignUpDataViewModel.viewModel.mbtiRelay.value)
        print(body)
        return Observable.create { observer in
            
            AF.request(url,
                       method: .post,
                       parameters: body,
                       encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Response<String>.self) { response in
                print("addUserInfo response\n\(response)")
                switch response.result{
                case .success(let data):
                    observer.onNext(data.isSuccess ?? false)
                case .failure(let error):
                    print("addUserInfo error! \n\(error)")
                }
            }
            
            return Disposables.create()
        }
    }
    
    
}
