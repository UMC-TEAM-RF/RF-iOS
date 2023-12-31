//
//  SignInViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/07/31.
//

import Foundation
import RxSwift
import RxRelay

/// MARK: Service ViewModel
final class SignInViewModel {
    
    private let disposeBag = DisposeBag()
    
    /// 로그인 Service 
    private let service = SignInService()
    
    /// 입력한 id 저장할 Relay
    var idRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// 입력한 password 저장할 Relay
    var passwordRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    
    // MARK: - Functions
    
    /// MARK: 로그인이 성공 했는지 반환하는 함수
    /// - Returns: true: 로그인 성공, false: 로그인 실패
    func checkingLogin() -> Observable<Bool>{
        let deviceToken = UserDefaults.standard.string(forKey: "deviceToken")
        return Observable.create { [weak self] observer in
            self?.service.loginService(id: self?.idRelay.value ?? "",
                                       pw: self?.passwordRelay.value ?? "",
                                       deviceToken: deviceToken ?? "")
                .subscribe(onNext:{ data in
                    if let accessToken = data.accessToken, let refreshToken = data.refreshToken, let id = data.userDemo?.userId{
                        UserDefaults.standard.set(accessToken, forKey: "AccessToken")
                        UserDefaults.standard.set(refreshToken, forKey: "RefreshToken")
                        UserDefaults.standard.set(id, forKey: "UserId")
                        
                        
                        //로그인 데이터를 mypage에 뿌려주기 위해서 임시로 짠 코드
                        SignUpDataViewModel.viewModel.idRelay.accept(data.userDemo?.loginId ?? "")
                        SignUpDataViewModel.viewModel.emailRelay.accept( data.userDemo?.email ?? "")
                        SignUpDataViewModel.viewModel.introduceSelfRelay.accept(data.userDemo?.introduce ?? "")
                        SignUpDataViewModel.viewModel.nickNameRelay.accept(data.userDemo?.nickname ?? "")
                        SignUpDataViewModel.viewModel.universityRelay.accept(data.userDemo?.university ?? "")
                        SignUpDataViewModel.viewModel.profileImageUrlRelay.accept(data.userDemo?.profileImageUrl ?? "")
                        
                        
                        observer.onNext(true)
                    }
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            return Disposables.create()
        }
    }
    
}
