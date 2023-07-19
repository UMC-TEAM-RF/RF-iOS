//
//  MeetingFiltering.swift
//  RF
//
//  Created by 정호진 on 2023/07/16.
//

import Foundation

struct MeetingFiltering{
    static let topButton: String = "나와 잘맞는 모임을 검색해보세요 "
    static let lookOnce: String = "모집 중인 모임만 보기"
    static let ageTitle: String = "모집 연령대"
    static let ageList: [String] = ["무관", "20초반", "20중반", "20후반"]
    static let joinNumber: String = "모집 인원"
    static let joinNumberList: [String] = ["1:1 소모임", "2인 이상 모임", "인원 설정하기"]
    static let interestingTitle: String = "관심 주제 설정"
    static let interestingTopicList: [String] = ["스포츠1", "스포츠2", "스포츠3", "스포츠4", "스포츠5", "스포츠6", "스포츠7", "스포츠8", "스포츠9"]
    static let filterClear: String = "필터 초기화"
    static let maxSelectionCount = 3
}
