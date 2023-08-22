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
    var meetingAllMember: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 2)
    
    /// 모임 한국인 멤버
    var meetingKoreanMember: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    
    /// 선호 연령대
    var preferAge: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    /// 사용 언어
    var language: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    /// 활동 장소
    var place: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    /// 규칙
    var rule: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [])
    
    
    
    // MARK: - Logic
    
    /// 모든 조건들을 다 선택했는지 확인하는 함수
    func clcikedNextButton() -> Observable<Bool> {
        Observable.zip(meetingAllMember,
                                 meetingKoreanMember,
                                 preferAge,
                                 language,
                                 place,
                                 rule) { AllMember, kMember, age, language, place, rules in
            return AllMember != 0 && kMember != 0 && !age.isEmpty && !language.isEmpty && !place.isEmpty && !rules.isEmpty
        }
    }
    
    
    /// 모든 조건들을 다 선택했는지 확인하는 함수
    ///  다음 버튼 색상 변경 용도
    func checkAllDatas() -> Observable<Bool> {
        Observable.combineLatest(meetingAllMember,
                                 meetingKoreanMember,
                                 preferAge,
                                 language,
                                 place,
                                 rule) { AllMember, kMember, age, language, place, rules in
            print("1: \(AllMember), 2: \(kMember), 3: \(age), 4: \(language), 5: \(place), 6: \(rules)")
            return AllMember != 0 && kMember != 0 && !age.isEmpty && !language.isEmpty && !place.isEmpty && !rules.isEmpty
        }
    }
    
}
