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
    
    /// MARK: 학교 리스트
    var universityRelay: BehaviorRelay<[KVO]> = BehaviorRelay(value: [])
    
    /// MARK: 필터링된 학교
    var filteringUniversityRelay: BehaviorRelay<[KVO]> = BehaviorRelay(value: [])
    
    /// MARK: 선택된 학교
    var selectedUniversity: BehaviorRelay<KVO> = BehaviorRelay(value: KVO())
    
    /// MARK: Check Filtering
    var isFiltering: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private let disposeBag = DisposeBag()
    
    /// dummy data
    func inputUniversity(){
        var list: [KVO] = []
        
        EnumFile.enumfile.enumList
            .bind { enums in
                list = enums.university ?? []
            }
            .disposed(by: disposeBag)
        universityRelay.accept(list)
    }
    
    /// MARK: 필터링 후 반환
    func filteringUniversity(text: String) {
        if text == ""{
            filteringUniversityRelay.accept(universityRelay.value)
        }
        else{
            let list = universityRelay.value.filter { $0.value?.localizedCaseInsensitiveContains(text) ?? false }
            filteringUniversityRelay.accept(list)
        }
    }
    
    
    // MARK: - API Connect
    
    
}
