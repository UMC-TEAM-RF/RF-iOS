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
    
    /// 중복 확인을 통과 했는지 확인하는 Relay
    var overlapCheckRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    /// 비밀번호 확인이 통과 했는지 확인하는 Relay
    var confirmPasswordRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    // MARK: - Logic
    
    
    /// '비밀번호 확인' 하는 함수
    func confirmPassword( _ password: String){
        let pw = pwRelay.value
        
        if !password.isEmpty && !pw.isEmpty && password == pw{
            confirmPasswordRelay.accept(true)
        }
        else{
            confirmPasswordRelay.accept(false)
        }
    }
    
    /// 아이디 중복확인, 비밀번호 확인이 통과 했는지 확인하는 함수
    func checkTotalInformation() -> Observable<Bool>{
        let overlapId = overlapCheckRelay.value
        let confirmPw = confirmPasswordRelay.value
        
        return Observable.create { [weak self] observer in
            
            Observable.combineLatest(self?.overlapCheckRelay ?? BehaviorRelay(value: false),
                                     self?.confirmPasswordRelay ?? BehaviorRelay(value: false))
            .subscribe(onNext: { first, second in
                if first && second{
                    observer.onNext(true)
                }
                else{
                    observer.onNext(false)
                }
            })
            .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
    }
    
    
    // MARK: - API Connect Functions
    
    /// 아이디 중복 체크
    func checkOverlapId() {
        service.checkOverlapId(userId: "")
            .bind { [weak self] check in
                self?.overlapCheckRelay.accept(true)
            }
            .disposed(by: disposeBag)
    }
}
