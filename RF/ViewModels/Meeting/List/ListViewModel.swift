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
        
        
        
        meetingList.append(Meeting(id: 1,
                                   name: "짜장 미친자 모임",
                                   memberCount: 5,
                                   nativeCount: 2,
                                   interests: [ "FOOD", "CAFE", "COUNTRY"],
                                   content: "짜장 같이먹어요!",
                                   rules: ["a","b","c"],
                                   preferAges: "EARLY_TWENTIES",
                                   language:  "KOREAN",
                                   location: "인하대학교 후문",
                                   ownerId: 1,
                                   imageFilePath: "soccer",
                                   users: []))
        
        profileList.append("soccer")
        profileList.append("soccer")
        profileList.append("soccer")
        
        /*
         
         API Connect 
         */
        
        userProfileListRelay.accept(profileList)
        meetingListRelay.accept(meetingList)
    }
    
}
