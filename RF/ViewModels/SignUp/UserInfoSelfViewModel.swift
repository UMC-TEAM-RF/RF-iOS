//
//  UserInfoSelfViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation
import RxSwift
import RxRelay

final class UserInfoSelfViewModel {
    
    /// 한줄 소개하는 문장 
    var introduceSelfRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
        
    
    // MARK: - Logic
    
    func checkIntroduce() -> Observable<Bool>{
        let intro = introduceSelfRelay.value
        
        return Observable.create { observer in
            if intro != ""{
                observer.onNext(true)
            }
            else{
                observer.onNext(false)
            }
            return Disposables.create()
        }
    }
}
