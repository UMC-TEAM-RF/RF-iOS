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
    private let disposeBag = DisposeBag()
    
    /// MARK: 국가 리스트
    var countryRelay: BehaviorRelay<[KVO]> = BehaviorRelay(value: [])
    
    /// MARK: 필터링된 국가
    var filteringCountryRelay: BehaviorRelay<[KVO]> = BehaviorRelay(value: [])
    
    /// MARK: 선택된 나라
    var selectedCountry: BehaviorRelay<Set<KVO>> = BehaviorRelay<Set<KVO>>(value: [])
    
    /// MARK: Check Filtering
    var isFiltering: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    /// dummy data
    func inputCountry(){
        var list: [KVO] = []
        
        EnumFile.enumfile.enumList
            .bind { enums in
                list = enums.country ?? []
            }
            .disposed(by: disposeBag)
        
        countryRelay.accept(list)
    }
    
    /// MARK: 필터링 후 반환
    func filteringCountry(text: String) {
        if text == ""{
            filteringCountryRelay.accept(countryRelay.value)
        }
        else{
            let list = countryRelay.value.filter { $0.value?.localizedCaseInsensitiveContains(text) ?? false}
            filteringCountryRelay.accept(list)
        }
    }
    
    func checkMarkSelectedCountry(country: String) -> Bool {
        let list = selectedCountry.value.filter{$0.value == country}
        
        if !list.isEmpty{
            return true
        }
        return false
    }
    
    /// MARK: interesting CollectionView에서 셀 선택했을 때 실행
    func selectedInterestingItems(at country: KVO) {
        var selectedItems = selectedCountry.value
        
        if selectedItems.contains(country) {
            selectedItems.remove(country)
        }
        else if selectedItems.count < 3 {
            selectedItems.insert(country)
        }
        else {
            return
        }
        selectedCountry.accept(selectedItems)
    }
}
