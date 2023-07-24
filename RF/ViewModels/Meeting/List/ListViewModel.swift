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
    var meetingListRelay: BehaviorRelay<[MeetingList]> = BehaviorRelay(value: [])
    
    /// test Data
    func getData(){
        var meetingList: [MeetingList] = []
        
        meetingList.append(MeetingList(imageList: [], meetingTitle: "언어 교환", university: "알프1", country: "🇰🇷", like: true))
        meetingList.append(MeetingList(imageList: [], meetingTitle: "언어 교환", university: "알프2", country: "🇰🇷", like: true))
        meetingList.append(MeetingList(imageList: [], meetingTitle: "언어 교환", university: "알프3", country: "🇰🇷", like: true))
        meetingList.append(MeetingList(imageList: [], meetingTitle: "언어 교환", university: "알프4", country: "🇰🇷", like: false))
        meetingList.append(MeetingList(imageList: [], meetingTitle: "언어 교환", university: "알프5", country: "🇰🇷", like: false))
        meetingList.append(MeetingList(imageList: [], meetingTitle: "언어 교환", university: "알프6", country: "🇰🇷", like: false))
        
        meetingListRelay.accept(meetingList)
    }
    
    
    /// 모임 목록 개수 반환 함수
    func returnMeetingListCount() -> Int{ return meetingListRelay.value.count}
    
}
