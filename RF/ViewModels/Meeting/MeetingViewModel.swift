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
    
}
