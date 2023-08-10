//
//  SetDetailInfoViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/10.
//

import Foundation
import RxSwift
import RxRelay

final class SetDetailInfoViewModel {
    
    /// 모임 전체 멤버
    var meetingAllMember: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    
    /// 모임 한국인 멤버
    var meetingKoreanMember: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    
    /// 선호 연령대
    var preferAge: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    /// 사용 언어
    var languages: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    /// 활동 장소
    var place: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    /// 규칙
    var rule: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [])
    
    
    
}
