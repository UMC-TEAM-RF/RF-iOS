//
//  ChoiceCountryViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/01.
//

import Foundation
import RxSwift
import RxRelay

/// 관심 언어
final class ChoiceInterestingLanguageViewModel{
    
    /// MARK: 언어 리스트
    var languageRelay: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    /// MARK: 필터링된 언어
    var filteringLanguageRelay: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    /// MARK: 선택된 언어
    var selectedLanguage: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// MARK: Check Filtering
    var isFiltering: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    /// dummy data
    func inputCountry(){
        var list: [String] = []
        
        list.append("한국어")
        list.append("영어")
        list.append("스페인어")
        list.append("일본어")
        list.append("중국어")
        
        languageRelay.accept(list)
    }
    
    /// MARK: 필터링 후 반환
    func filteringLanguage(text: String) {
        if text == ""{
            filteringLanguageRelay.accept(languageRelay.value)
        }
        else{
            let list = languageRelay.value.filter { $0.localizedCaseInsensitiveContains(text) }
            filteringLanguageRelay.accept(list)
        }
    }
    
}
