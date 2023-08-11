//
//  SetDescriptViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/10.
//

import Foundation
import RxSwift
import RxRelay

final class SetDescriptViewModel {
    private let disposeBag = DisposeBag()
    private let minTextLength = 10
    
    /// 모임 배너 이미지
    var meetingImage: BehaviorRelay<UIImage> = BehaviorRelay<UIImage>(value: UIImage())
    
    /// 입력한 모임 설명
    let meetingDescription = BehaviorRelay<String>(value: "")
    
    /// 입력한 모임 색상
    let meetingDescriptionColor = BehaviorRelay<String>(value: "")
    
    /// 유효하게 입력 했는지 확인
    func isValid() -> Observable<Bool>{
        
        return Observable.create { [weak self] observer in
            

            Observable.combineLatest(self?.meetingDescription ?? BehaviorRelay<String>(value: ""),
                           self?.meetingDescriptionColor ?? BehaviorRelay<String>(value: ""))
            .subscribe(onNext:{ [weak self] first, second in
                if (first.trimmingCharacters(in: .whitespaces).count >= self?.minTextLength ?? 0) && (second == "black"){
                    observer.onNext(true)
                }
                else {
                    observer.onNext(false)
                }
            })
            .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
    }
    
}
