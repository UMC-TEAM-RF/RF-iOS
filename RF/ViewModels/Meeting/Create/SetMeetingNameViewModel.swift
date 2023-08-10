//
//  SetMeetingNameViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/10.
//

import Foundation
import RxSwift
import RxRelay

final class SetMeetingNameViewModel {
    let placeholder = "2글자 이상"
    let minTextLength = 2
    
    /// 입력한 모임 이름
    let meetingName = BehaviorRelay<String>(value: "")
    
    /// 유효하게 입력 했는지 확인
    func isValid() -> Observable<Bool>{
       return meetingName.map { $0.trimmingCharacters(in: .whitespaces).count >= self.minTextLength }
    }
    
}
