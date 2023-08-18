//
//  DetailMeetingHomeViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/16.
//

import Foundation
import RxSwift
import RxRelay
import SnapKit

final class DetailMeetingHomeViewModel {
    private let service = MeetingService()
    private let disposeBag = DisposeBag()
    
    /// 모임 소개 Constraint
    var meetingIntroductionUIViewConstraint: BehaviorRelay<Constraint?> = BehaviorRelay<Constraint?>(value: nil)
    
    /// 모임 정보
    var meetingInfo: BehaviorRelay<Meeting?> = BehaviorRelay(value: nil)
    
    /// 모임 소개글 길이에 따라 높이 길이 계산
    func resizeMeetingIntroductionHeight(meetingIntroduction: UILabel, longText: String){
        meetingIntroduction.setTextWithLineHeight(text: longText, lineHeight: 20)
        let newHeight = meetingIntroduction.sizeThatFits(CGSize(width: meetingIntroduction.frame.width, height: .greatestFiniteMagnitude)).height + 30
        meetingIntroductionUIViewConstraint.value?.update(offset: newHeight)
    }
    
    /// 모임 데이터 가져옴
    func getData(meetingIntroduction: UILabel, id: Int) {
        service.requestMeetingInfo(id: id)
            .subscribe(onNext:{ [weak self] data in
                self?.meetingInfo.accept(data)
                self?.resizeMeetingIntroductionHeight(meetingIntroduction: meetingIntroduction,
                                                      longText: self?.meetingInfo.value?.content ?? "unknown")
            },onError: { error in
                print("service.requestMeetingInfo error!\n\(error)")
            })
            .disposed(by: disposeBag)
        
    }
}
