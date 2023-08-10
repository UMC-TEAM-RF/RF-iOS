//
//  CreateViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/10.
//

import Foundation
import RxRelay
import RxSwift

final class CreateViewModel {
    static let viewModel = CreateViewModel()
    private init() {}
    
    /// 입력한 모임 이름
    let meetingName = BehaviorRelay<String>(value: "")
    
    /// 취미 관심사
    var interestingRelay: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [])
    
    /// 모임 배너 이미지
    /// value: 기본 이미지로 바꿔야함
    var meetingImage: BehaviorRelay<UIImage> = BehaviorRelay<UIImage>(value: UIImage())
    /// 모임 소개
    let meetingDescription = BehaviorRelay<String>(value: "")
    
}
