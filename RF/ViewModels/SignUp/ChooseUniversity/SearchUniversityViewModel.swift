//
//  SearchUniversityViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/01.
//

import Foundation
import RxSwift
import RxRelay

/// 학교 선택
final class SearchUniversityViewModel{
    
    /// MARK: 국가 리스트
    var universityRelay: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    /// MARK: 필터링된 국가
    var filteringUniversityRelay: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    /// MARK: 선택된 나라
    var selectedUniversity: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// MARK: Check Filtering
    var isFiltering: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    /// dummy data
    func inputUniversity(){
        var list: [String] = []
        
        list.append("인하대학교")
        list.append("한국공학대학교")
        list.append("한양대에리카")
        list.append("가톨릭대학교")
        
        universityRelay.accept(list)
    }
    
    /// MARK: 필터링 후 반환
    func filteringUniversity(text: String) {
        if text == ""{
            filteringUniversityRelay.accept(universityRelay.value)
        }
        else{
            let list = universityRelay.value.filter { $0.localizedCaseInsensitiveContains(text) }
            filteringUniversityRelay.accept(list)
        }
    }
    
}
