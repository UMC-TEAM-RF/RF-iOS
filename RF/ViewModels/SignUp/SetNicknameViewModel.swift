//
//  SetNicknameViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation
import RxSwift
import RxRelay

final class SetNicknameViewModel {
    
    private let disposeBag = DisposeBag()
    private let service = NickNameService()
    /// nickName Relay
    var nickNameRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// check overlap nickName
    var checknickNameRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    /// finish checking nickName
    var finalNickNameRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    // MARK: - Logic
    
    ///  중복확인한 닉네임과 입력한 닉네임과 같은지 확인하는 함수
    /// - Returns: Observable<Bool>
    /// - Description: true: 둘이 같음, false: 둘이 다름(중복확인 필요)
    func checkFinalNickName() -> Observable<Bool>{
        let finalName = finalNickNameRelay.value
        let name = nickNameRelay.value
        
        return Observable.create { observer in
            if !finalName.isEmpty && !name.isEmpty && finalName == name {
                observer.onNext(true)
            }
            else{
                observer.onNext(false)
            }
            return Disposables.create()
        }
    
    }
    
    
    // MARK: - API Connect Functions
    
    /// 닉네임 중복확인하는 함수
    func checkNickName() -> Observable<Bool>{
        let name = nickNameRelay.value
        
        return Observable.create { [weak self] observer in
            self?.service.checkOverlapNickName(name: name)
            .bind { [weak self] check in
                if !check{
                    self?.finalNickNameRelay.accept(name)
                }
                else{
                    observer.onNext(check)
                }
            }
            .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
    }
    
}
