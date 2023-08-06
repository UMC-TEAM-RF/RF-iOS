//
//  CertificatedEmailViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/07.
//

import Foundation
import RxSwift
import RxRelay

final class CertificatedEmailViewModel {
    private let service = EmailService()
    private let disposeBag = DisposeBag()
    
    /// 이메일
    var emailRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// 인증 코드
    var codeRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// 모든 인증이 다 끝난 경우
    var clearAllSubject: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    // MARK: - API Connect
    
    /// 이메일로 인증번호 전송하는 함수
    func sendingEmail() -> Observable<Void>{
        let email = emailRelay.value
        let university = SignUpDataViewModel.viewModel.universityRelay.value
        
        return Observable.create { [weak self] observer in
            self?.service.sendingEmail(email: email, university: university)
                .subscribe(
                    onNext: { data in
                        observer.onNext(())
                    },onError: { error in
                        observer.onError(error)
                    })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
    }
    
    /// 인증번호 인증하는 함수
    func checkEmailCode() -> Observable<Void>{
        let email = emailRelay.value
        let university = SignUpDataViewModel.viewModel.universityRelay.value
        let code = codeRelay.value
        
        return Observable.create { [weak self] observer in
            self?.service.checkEmailCode(email: email, university: university, code: code)
                .subscribe(
                    onNext: { _ in
                        observer.onNext(())
                        self?.clearAllSubject.accept(true)
                    },onError: { error in
                        observer.onError(error)
                    })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
    }
    
}
