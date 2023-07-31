//
//  SignInViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/07/31.
//

import Foundation
import RxSwift
import RxRelay

final class SignInViewModel {
    
    private let disposeBag = DisposeBag()
    
    /// 입력한 id 저장할 Relay
    var idRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// 입력한 password 저장할 Relay
    var passWordRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// MARK: 로그인이 성공 했는지 반환하는 함수
    /// - Returns: true: 로그인 성공, false: 로그인 실패
    func checkingLogin() -> Observable<Bool>{
        
        return Observable.create { observer in
            
            return Disposables.create()
        }
    }
    
}
