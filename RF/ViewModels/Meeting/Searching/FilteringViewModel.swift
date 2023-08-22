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
    
    /// 모집 상태
    var joinStatusRelay = BehaviorRelay<IndexPath>(value: IndexPath())
    
    /// 모집 인원
    var joinNumberRelay = BehaviorRelay<IndexPath>(value: IndexPath())

    
    
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
    
    /// MARK: 나이 선택했을 때 실행
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
    
    /// MARK: 나이 선택했을 때 실행
    func selectedjoinStatusItem(at: IndexPath){
        var selectItem = joinStatusRelay.value
        
        if selectItem == at{
            selectItem = IndexPath()
        }
        else{
            selectItem = at
        }
        
        print("selected Join Status IndexPath:  \(selectItem)")
        joinStatusRelay.accept(selectItem)
    }
    
    /// MARK: 나이 선택했을 때 실행
    func selectedJoinNumberItem(at: IndexPath){
        var selectItem = joinNumberRelay.value
        
        if selectItem == at{
            selectItem = IndexPath()
        }
        else{
            selectItem = at
        }
        
        print("selected JoinNumber IndexPath:  \(selectItem)")
        joinNumberRelay.accept(selectItem)
    }
    
    /// MARK: 필터 초기화 버튼 눌렀을 때
    func clickResetBtn(){
        joinStatusRelay.accept(IndexPath())
        ageRelay.accept(IndexPath())
        
        var selectedInterestingTopicItems = interestingTopicRelay.value
        selectedInterestingTopicItems = []
        interestingTopicRelay.accept(selectedInterestingTopicItems)
        
        joinNumberRelay.accept(IndexPath())
    }
    
    /// 관심사 포함되어 있는지 확인
    func checkRemainInterestingTopicItems(at indexPath: IndexPath) -> Bool {
        let selectedItems = interestingTopicRelay.value
        
        return selectedItems.contains(indexPath) ? true : false
    }
    
    /// 선택한 나이 포함되어 있는지 확인
    func checkRemainAgeItem(at indexPath: IndexPath) -> Bool {
        let selectedItems = ageRelay.value
        
        return selectedItems == indexPath ? true : false
    }
    
    /// 선택한 모집 인원 포함되어 있는지 확인
    func checkRemainjoinNumberItems(at indexPath: IndexPath) -> Bool {
        let selectedItems = joinNumberRelay.value
        
        return selectedItems == indexPath ? true : false
    }
    
    /// 선택한 모집 상태 포함되어 있는지 확인
    func checkJoinStatusItem(at indexPath: IndexPath) -> Bool {
        let selectedItems = joinStatusRelay.value
        
        return selectedItems == indexPath ? true : false
    }
}
