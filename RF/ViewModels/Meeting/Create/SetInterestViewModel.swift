//
//  SetInterestViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/10.
//

import Foundation
import RxSwift
import RxRelay

final class SetInterestViewModel {
    /// 취미 관심사
    var interestingRelay: BehaviorRelay<Set<IndexPath>> = BehaviorRelay<Set<IndexPath>>(value: [])
    
    /// 모두 선택했는지 확인
    var checkSelectedAll : BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Logic
    
    /// MARK: interesting CollectionView에서 셀 선택했을 때 실행
    func selectedInterestingItems(at indexPath: IndexPath) {
        var selectedItems = interestingRelay.value
        
        if selectedItems.contains(indexPath) {
            selectedItems.remove(indexPath)
            checkSelectedAll.accept(false)
            print("deselected interesting \(Interest.list[indexPath.item])")
        }
        else if selectedItems.count < 3 {
            selectedItems.insert(indexPath)
            
            if selectedItems.count == 3{ checkSelectedAll.accept(true) }
            else { checkSelectedAll.accept(false) }
            print("selected interesting \(Interest.list[indexPath.item])")
        }
        else {
            return
        }
        interestingRelay.accept(selectedItems)
    }
    
}
