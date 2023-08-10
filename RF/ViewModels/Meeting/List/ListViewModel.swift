//
//  ListViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/07/24.
//

import Foundation
import RxSwift
import RxRelay

// MARK: List ViewModel
final class ListViewModel {
    
    /// MARK: 모임 목록 Relay
    var meetingListRelay: BehaviorRelay<[Meeting]> = BehaviorRelay(value: [])
    var userProfileListRelay: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Logic
    
    /// MARK: tableview Cell 제거 하는 함수
    func removeElement(index: Int){
        var list = meetingListRelay.value
        list.remove(at: index)
        meetingListRelay.accept(list)
    }
    
    /// 모임 목록 개수 반환 함수
    func returnMeetingListCount() -> Int{ return meetingListRelay.value.count}
    
    
    // MARK: - API Connect
    
    /// test Data
    func getData(){
        var meetingList: [Meeting] = []
        var profileList: [String] = []
        
        /*
         
         API Connect 
         */
        
        userProfileListRelay.accept(profileList)
        meetingListRelay.accept(meetingList)
    }
    
}
