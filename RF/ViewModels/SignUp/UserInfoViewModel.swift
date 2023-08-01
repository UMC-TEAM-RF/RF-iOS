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
    var interestingCountry: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// MARK: 선택한 관심 언어
    var interestingLanguage: BehaviorRelay<String> = BehaviorRelay(value: "")
}
