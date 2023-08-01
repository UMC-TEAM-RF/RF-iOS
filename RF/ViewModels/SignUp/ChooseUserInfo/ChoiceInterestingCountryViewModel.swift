//
//  ChoiceCountryViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/01.
//

import Foundation
import RxSwift
import RxRelay

/// 관심 국가
final class ChoiceInterestingCountryViewModel{
    
    /// MARK: 국가 리스트
    var countryRelay: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    /// MARK: 필터링된 국가
    var filteringCountryRelay: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    /// MARK: 선택된 나라
    var selectedCountry: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// MARK: Check Filtering
    var isFiltering: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    /// dummy data
    func inputCountry(){
        var list: [String] = []
        
        list.append("대한민국")
        list.append("미국")
        list.append("중국")
        list.append("일본")
        
        countryRelay.accept(list)
    }
    
    /// MARK: 필터링 후 반환
    func filteringCountry(text: String) {
        if text == ""{
            filteringCountryRelay.accept(countryRelay.value)
        }
        else{
            let list = countryRelay.value.filter { $0.localizedCaseInsensitiveContains(text) }
            filteringCountryRelay.accept(list)
        }
    }
    
}
