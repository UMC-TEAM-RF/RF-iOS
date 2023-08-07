//
//  MeetingViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/07.
//

import Foundation
import RxSwift
import RxRelay

final class MeetingViewModel {
    private let disposeBag = DisposeBag()
    private let service = MeetingService()
    
    /// 모임 리스트
    var meetingList: BehaviorRelay<[Meeting]> = BehaviorRelay(value: [])
    
    // MARK: - API Connect
    
    /// 모임 리스트를 받는 함수
    func getMeetingList() {
        
        service.requestMeetingList(userId: 0)    // UserDefault에서 userID 가져와야함
            .subscribe(
                onNext:{ [weak self] list in
                    self?.meetingList.accept(list)
                }
                ,onError: { error in
                    print("getMeetingList api connect error\n \(error)")
                })
            .disposed(by: disposeBag)
    }
    
    
}
