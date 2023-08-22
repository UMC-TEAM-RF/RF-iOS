//
//  ReportViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/22.
//

import Foundation
import RxSwift
import RxRelay

final class ReportViewModel {
    
    /// 신고 내역
    var reportText: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// 모임 Id
    var meetingId:  BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    private let service = ReportService()
    
    // MARK: - API Connect
    
    /// 신고 
    func reportFuction() -> Observable<Bool>{
        let userId = UserDefaults.standard.string(forKey: "UserId") ?? ""
        let report = Report(userId: Int(userId) ?? 0,
                            meetingId: meetingId.value,
                            content: reportText.value)
        
        return service.reportParty(report)
    }
    
}
