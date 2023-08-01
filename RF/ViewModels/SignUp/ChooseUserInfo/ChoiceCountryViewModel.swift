//
//  ChoiceCountryViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/01.
//

import Foundation
import RxSwift
import RxRelay

/// 출생 국가
final class ChoiceBornCountryViewModel{
    
    /// MARK: 국가 리스트
    var countryRelay: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    /// MARK: 선택된 나라
    var selectedCountry:BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// dummy data
    func inputCountry(){
        var list: [String] = []
        
        list.append("대한민국")
        list.append("미국")
        list.append("중국")
        list.append("일본")
        
        countryRelay.accept(list)
    }
}
