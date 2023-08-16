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
    func getData(meetingIntroduction: UILabel) {
        
        let longText = """
        1해외 축구 팬들 모여라! 같이 이야기도 나누고
        직접 축구도 같이 해봐요!
        다른 국가의 분들은 어느 구단을 좋아하시나요?
        """
        
        meetingInfo.accept(Meeting(id: 1,
                            name: "짜장 미친자 모임",
                            memberCount: 5,
                            nativeCount: 2,
                            interests: [ "FOOD", "CAFE", "COUNTRY"],
                            content: longText,
                            rules: ["aaasafsdfafdsaf","bvbcvcbcbcbcbcvbcbc","cczcxzcvzxvxvxzcvvcvcxvxv"],
                            preferAges: "EARLY_TWENTIES",
                            language:  "KOREAN",
                            location: "인하대학교 후문",
                            ownerId: 1,
                            imageFilePath: "soccer",
                            users: [User(userID: nil,
                                         password: nil,
                                         university: nil,
                                         nickname: "AA",
                                         entrance: nil,
                                         country: "KOREA",
                                         introduce: nil,
                                         interestLanguage: nil,
                                         interestCountry: nil,
                                         interest: nil,
                                         mbti: nil,
                                         profileImageUrl: "LogoImage"),
                                    User(userID: nil,
                                                 password: nil,
                                                 university: nil,
                                                 nickname: "AA",
                                                 entrance: nil,
                                                 country: "KOREA",
                                                 introduce: nil,
                                                 interestLanguage: nil,
                                                 interestCountry: nil,
                                                 interest: nil,
                                                 mbti: nil,
                                                 profileImageUrl: "LogoImage"),
                                    User(userID: nil,
                                                 password: nil,
                                                 university: nil,
                                                 nickname: "AA",
                                                 entrance: nil,
                                                 country: "KOREA",
                                                 introduce: nil,
                                                 interestLanguage: nil,
                                                 interestCountry: nil,
                                                 interest: nil,
                                                 mbti: nil,
                                                 profileImageUrl: "LogoImage")]))
            
        
        resizeMeetingIntroductionHeight(meetingIntroduction: meetingIntroduction,
                                        longText: meetingInfo.value?.content ?? "unknown")
    }
}
