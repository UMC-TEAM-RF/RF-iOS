//
//  SignUpViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/04.
//

import Foundation
import RxSwift
import RxRelay

///  회원가입 첫번째 화면 ViewModel
///  아이디, 비밀번호 입력하는 화면 ViewModel
final class SignUpViewModel {
    private let disposeBag = DisposeBag()
    /// 회원 가입 service
    private let service = SignUpService()
    
    /// 입력한 아이디 저장하는 Relay
    var idRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// 입력한 비밀번호 저장하는 Relay
    var pwRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    
    var overlayCheck: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    // MARK: - API Connect Functions
    
    /// 아이디 중복 체크
    /// - Returns: Observable<Bool>
    func checkOverlapId() -> Observable<Bool>{
        
        return Observable.create { [weak self] observer in
            self?.service.checkOverlapId(userId: "")
                .bind { check in
                    observer.onNext(check)
                }
                .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
    }
}
