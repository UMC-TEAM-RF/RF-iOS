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
    
    /// MARK: 로그인이 성공 했는지 반환하는 함수
    /// - Returns: true: 로그인 성공, false: 로그인 실패
    func checkingLogin() -> Observable<Bool>{
        return Observable.create { [weak self] observer in
            self?.service.loginService(id: self?.idRelay.value ?? "", pw: self?.passwordRelay.value ?? "")
                .subscribe(onNext:{ data in
                    if let check = data.isSuccess{
                        UserDefaults.standard.set(data.result.token ?? "", forKey: "AccessToken")
                    }
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            return Disposables.create()
        }
    }
    
}
