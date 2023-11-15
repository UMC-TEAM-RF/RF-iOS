//
//  UserInfoViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/02.
//

import Foundation
import RxSwift
import RxRelay

final class UserInfoViewModel {
    
    /// MARK: 선택한 출생 국가
    var bornCountry: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// MARK: 선택한 관심 국가
    var interestingCountry: BehaviorRelay<Set<KVO>> = BehaviorRelay<Set<KVO>>(value: [])
    
    /// MARK: 선택한 관심 언어
    var interestingLanguage: BehaviorRelay<Set<KVO>> = BehaviorRelay<Set<KVO>>(value: [])
    
    /// MARK: 선택한 학과
    var major: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Logic
    
    /// 선택지 모두를 선택했는지 확인하는 함수
    func checkSelectedAll() -> Observable<Bool>{
        
        let checkBorn = bornCountry.map { $0 != "" ? true : false }
        let checkCountry = interestingCountry.map { $0 != [] ? true : false }
        let checkLanguage = interestingLanguage.map { $0 != [] ? true : false }
        let checkMajor = major.map { $0 != "" ? true : false }
        
        return Observable.create { [weak self] observer in
            
            
            Observable.combineLatest(checkBorn,
                                     checkCountry,
                                     checkLanguage,
                                     checkMajor,
                                     resultSelector: { born, country, language, major in
                born && country && language && major
            })
            .subscribe(onNext: { check in
                observer.onNext(check)
            })
            .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
    }
    
    
}
