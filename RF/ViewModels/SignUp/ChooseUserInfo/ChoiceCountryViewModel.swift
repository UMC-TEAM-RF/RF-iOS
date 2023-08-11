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
    private let disposeBag = DisposeBag()
    
    /// MARK: 국가 리스트
    var countryRelay: BehaviorRelay<[KVO]> = BehaviorRelay(value: [])
    
    /// MARK: 필터링된 국가
    var filteringCountryRelay: BehaviorRelay<[KVO]> = BehaviorRelay(value: [])
    
    /// MARK: 선택된 나라
    var selectedCountry: BehaviorRelay<KVO> = BehaviorRelay(value: KVO())
    
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
            let list = countryRelay.value.filter { $0.value?.localizedCaseInsensitiveContains(text) ?? false }
            filteringCountryRelay.accept(list)
        }
    }
    
}
