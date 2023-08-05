//
//  ChooseUniversityViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation
import RxSwift
import RxRelay

final class ChooseUniversityViewModel {
    
    /// 선택한 학번
    var yearRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// 선택한 학교
    var universityRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Logic
    
    /// 버튼 색상 감지 용
    func observeSelectedForChangeColor() -> Observable<Bool> {
        let year = yearRelay.map { $0 != "" ? true : false}
        let university = universityRelay.map { $0 != "" ? true : false}
        
        return Observable.create { [weak self]  observer in
            Observable.combineLatest(year, university)
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
    
    /// 모두 다 선택 했는지 확인하는 함수
    func checkSelected() -> Observable<Bool>{
        let year = yearRelay.value != "" ? true : false
        let university = universityRelay.value != "" ? true : false
        
        return Observable.create { observer in
            
            if year && university {
                observer.onNext(true)
            }
            else{
                observer.onNext(false)
            }
            
            return Disposables.create()
        }
    }
    
    
    
    // MARK: - API Connect
    
}
