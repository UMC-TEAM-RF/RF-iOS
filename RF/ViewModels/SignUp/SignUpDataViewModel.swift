//
//  SignUpDataViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation
import RxRelay
import RxSwift

/// Singleton Pattern으로 회원가입 정보 저장하는 ViewModel
final class SignUpDataViewModel {
    static let viewModel = SignUpDataViewModel()
    private let service = SignUpService()
    private init() {}
    private let disposeBag = DisposeBag()
    
    /// 입력한 아이디 저장하는 Relay
    var idRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// 입력한 비밀번호 저장하는 Relay
    var pwRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// 입력한 이메일 저장하는 Relay
    var emailRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// 선택한 학번
    var yearRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// 선택한 학교
    var universityRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// nickName Relay
    var nickNameRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// 한줄 소개하는 문장
    var introduceSelfRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// MARK: 선택한 출생 국가
    var bornCountry: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// MARK: 선택한 관심 국가
    var interestingCountry: BehaviorRelay<Set<KVO>> = BehaviorRelay<Set<KVO>>(value: [])
    
    /// MARK: 선택한 관심 언어
    var interestingLanguage: BehaviorRelay<Set<KVO>> = BehaviorRelay<Set<KVO>>(value: [])
    
    /// 선택한 라이프 스타일
    var lifeStyleRelay: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    /// 취미 관심사
    var interestingRelay: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [])
    
    /// MBTI
    var mbtiRelay: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    /// profileImageURL
    var profileImageUrlRelay: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    
    // MARK: - API Connect
    
    /// 유저 정보 등록하는 함수
    func totalSignUp() -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            self?.service.addUserInfo()
                .subscribe(onNext: { check in
                    observer.onNext(check)
                })
                .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
    }
    
}
