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
    
    private let disposeBag = DisposeBag()
    private let service = MeetingService()
    private var page = 0
    private var size = 10
    
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
    
    /// MARK: get meeting list
    ///  check: true: 처음 요청하는 것, false: 두번째 부터 요청
    func getData(check: Bool){
        var meetingList: [Meeting] = meetingListRelay.value
        
        if check{
            page = 0
            meetingList = []
        }
        else{
            page += 1
        }
        
        service.getMyMeetingList(page: page, size: size)
            .subscribe(onNext:{ list in
                meetingList.append(contentsOf: list)
            },onError: { error in
                print("getData error! \(error)")
            })
            .disposed(by: disposeBag)
        
        meetingListRelay.accept(meetingList)
    }
    
}
