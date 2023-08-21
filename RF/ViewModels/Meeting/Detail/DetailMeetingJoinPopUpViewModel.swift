//
//  DetailMeetingJoinPopUpViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/16.
//

import Foundation
import RxSwift
import RxRelay

final class DetailMeetingJoinPopUpViewModel {
    private let service = DetailMeetingJoinService()
    /// meeting Id
    var meetingIdRelay: BehaviorRelay<Int?> = BehaviorRelay(value: nil)
    
    
    // MARK: - API Connect
    
    /// 모임 가입 신청하기
    func sendingJoin() -> Observable<Bool> {
        return service.sendingJoin(partyId: meetingIdRelay.value ?? 0)
    }
}
