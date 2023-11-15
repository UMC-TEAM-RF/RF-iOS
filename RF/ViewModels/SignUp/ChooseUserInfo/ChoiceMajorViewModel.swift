//
//  ChoiceCountryViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/01.
//

import Foundation
import RxSwift
import RxRelay

/// 학과
final class ChoiceMajorViewModel{
    private let disposeBag = DisposeBag()
    
    /// MARK: 국가 리스트
    var majorRelay: BehaviorRelay<[KVO]> = BehaviorRelay(value: [])
    
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
                list = enums.major ?? []
            }
            .disposed(by: disposeBag)
        
        majorRelay.accept(list)
    }
    
    /// MARK: 필터링 후 반환
    func filteringCountry(text: String) {
        if text == ""{
            filteringCountryRelay.accept(majorRelay.value)
        }
        else{
            let list = majorRelay.value.filter { $0.value?.localizedCaseInsensitiveContains(text) ?? false }
            filteringCountryRelay.accept(list)
        }
    }
    
}

