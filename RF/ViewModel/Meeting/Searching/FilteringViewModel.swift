//
//  Filtering.swift
//  RF
//
//  Created by 정호진 on 2023/07/17.
//

import Foundation
import RxSwift
import RxRelay

final class FilteringViewModel {
    
    /// 선택된 관심 주제 목록
    var interestingTopicRelay = BehaviorRelay<Set<IndexPath>>(value: [])
    
    /// 선택한 연령 대
    var ageRelay = BehaviorRelay<IndexPath>(value: IndexPath())
    
    /// MARK: interesting CollectionView에서 셀 선택했을 때 실행
    func selectedInterestingTopicItems(at indexPath: IndexPath) {
        var selectedItems = interestingTopicRelay.value
        
        if selectedItems.contains(indexPath) {
            selectedItems.remove(indexPath)
            print("deselected interesting \(MeetingFiltering.interestingTopicList[indexPath.row])")
        }
        else if selectedItems.count < MeetingFiltering.maxSelectionCount {
            selectedItems.insert(indexPath)
            print("selected interesting \(MeetingFiltering.interestingTopicList[indexPath.row])")
        }
        else {
            return
        }
        
        interestingTopicRelay.accept(selectedItems)
    }
    
    func selectedAgeItem(at: IndexPath){
        var selectItem = ageRelay.value
        
        if selectItem == at{
            selectItem = IndexPath()
        }
        else{
            selectItem = at
        }
        
        print("selected Age IndexPath:  \(selectItem)")
        ageRelay.accept(selectItem)
    }
    
}
