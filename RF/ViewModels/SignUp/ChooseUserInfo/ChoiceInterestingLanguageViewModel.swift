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
    private let disposeBag = DisposeBag()
    
    /// MARK: 언어 리스트
    var languageRelay: BehaviorRelay<[KVO]> = BehaviorRelay(value: [])
    
    /// MARK: 필터링된 언어
    var filteringLanguageRelay: BehaviorRelay<[KVO]> = BehaviorRelay(value: [])
    
    /// MARK: 선택된 언어
    var selectedLanguage: BehaviorRelay<Set<KVO>> = BehaviorRelay<Set<KVO>>(value: [])
    
    /// MARK: Check Filtering
    var isFiltering: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    /// input Data
    func inputLanguage(){
        var list: [KVO] = []
        
        EnumFile.enumfile.enumList
            .bind { enums in
                list = enums.language ?? []
            }
            .disposed(by: disposeBag)
        
        languageRelay.accept(list)
    }
    
    /// MARK: 필터링 후 반환
    func filteringLanguage(text: String) {
        if text == ""{
            filteringLanguageRelay.accept(languageRelay.value)
        }
        else{
            let list = languageRelay.value.filter { $0.value?.localizedCaseInsensitiveContains(text) ?? false}
            filteringLanguageRelay.accept(list)
        }
    }
    
    func checkMarkSelectedCountry(language: String) -> Bool {
        let list = selectedLanguage.value.filter{$0.value == language}
        
        if !list.isEmpty{
            return true
        }
        return false
    }
    
    /// MARK: interesting CollectionView에서 셀 선택했을 때 실행
    func selectedInterestingItems(at language: KVO) {
        var selectedItems = selectedLanguage.value
        
        if selectedItems.contains(language) {
            selectedItems.remove(language)
        }
        else if selectedItems.count < 3 {
            selectedItems.insert(language)
        }
        else {
            return
        }
        selectedLanguage.accept(selectedItems)
    }
    
}
