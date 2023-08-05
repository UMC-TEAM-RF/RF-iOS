//
//  PersonalInterestsViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation
import RxSwift
import RxRelay

final class PersonalInterestsViewModel{
    
    /// 선택한 라이프 스타일
    var lifeStyleRelay: BehaviorRelay<IndexPath> = BehaviorRelay<IndexPath>(value: IndexPath())
    
    /// 취미 관심사
    var interestingRelay: BehaviorRelay<Set<IndexPath>> = BehaviorRelay<Set<IndexPath>>(value: [])
    
    /// MBTI
    var mbtiRelay: BehaviorRelay<IndexPath> = BehaviorRelay<IndexPath>(value: IndexPath())
    
    
    // MARK: - Logic
    
    /// MARK: 라이프 스타일 선택
    func selectedLifeStyleItem(at: IndexPath){
        var selectItem = lifeStyleRelay.value
        
        if selectItem == at{
            selectItem = IndexPath()
        }
        else{
            selectItem = at
        }
        
        print("selected life Style IndexPath:  \(selectItem)")
        lifeStyleRelay.accept(selectItem)
    }
    
    /// MARK: interesting CollectionView에서 셀 선택했을 때 실행
    func selectedInterestingItems(at indexPath: IndexPath) {
        var selectedItems = interestingRelay.value
        
        if selectedItems.contains(indexPath) {
            selectedItems.remove(indexPath)
            print("deselected interesting \(Interest.list[indexPath.item])")
        }
        else if selectedItems.count < 3 {
            selectedItems.insert(indexPath)
            print("selected interesting \(Interest.list[indexPath.item])")
        }
        else {
            return
        }
        
        interestingRelay.accept(selectedItems)
    }
    
    /// MARK: MBTI CollectionView에서 셀 선택했을 때 실행
    func selectedMBTIItems(at indexPath: IndexPath) {
        var selectItem = mbtiRelay.value
        
        if selectItem == indexPath{
            selectItem = IndexPath()
        }
        else{
            selectItem = indexPath
        }
        
        print("selected life Style IndexPath:  \(selectItem)")
        mbtiRelay.accept(selectItem)
    }
    
    
    
}
