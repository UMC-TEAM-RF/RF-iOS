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
    private let service = MeetingService()
    private init() {}
    
    /// 입력한 모임 이름
    let meetingName = BehaviorRelay<String>(value: "")
    
    /// 취미 관심사
    var interestingRelay: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [])
    
    /// 모임 배너 이미지
    /// value: 기본 이미지로 바꿔야함
    var meetingImage: BehaviorRelay<UIImage?> = BehaviorRelay<UIImage?>(value: nil)
    
    /// 모임 소개
    let meetingDescription = BehaviorRelay<String>(value: "")
    
    /// 모임 전체 멤버
    var meetingAllMember: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    
    /// 모임 한국인 멤버
    var meetingKoreanMember: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    
    /// 선호 연령대
    var preferAge: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    /// 사용 언어
    var language: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    /// 활동 장소
    var place: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    /// 규칙
    var rule: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [])
    
    
    /// 모든 조건들을 다 선택했는지 확인하는 함수
    func clickedNextButton() -> Observable<Void> {

        let userId = UserDefaults.standard.string(forKey: "UserId") ?? ""
        
        let data = EnumFile.enumfile.enumList.value
        let lang = data.language?.filter{ $0.value == language.value }.first
        let preferage = data.preferAges?.filter{ $0.value == preferAge.value }.first
        
        
        let rules = rule.value.map{ rule in data.rule?.filter { $0.value == rule }.first?.key ?? ""}
        
        let model = Meeting(name: meetingName.value,
                            memberCount: meetingAllMember.value,
                            nativeCount: meetingKoreanMember.value,
                            interests: interestingRelay.value,
                            content: meetingDescription.value,
                            rules: rules,
                            preferAges: preferage?.key,
                            language: lang?.key,
                            location: place.value,
                            ownerId: Int(userId) ?? 0)
        
        let img = (meetingImage.value ?? UIImage(named: "meeting_\(Int.random(in: 1...5))")) ?? UIImage()

        // service
        return service.createMeeting(meeting: model, image: img).asObservable()
    }
}
