//
//  ViewConstants.swift
//  RF
//
//  Created by 이정동 on 2023/08/10.
//

import Foundation

// MARK: - Language

struct Language {
    static let list: [String] = ["한국어", "영어", "중국어", "일본어", "불어", "베트남어"]
    static let listWithCode: [String: String] = [
        "ko": "한국어",
        "en": "영어",
        "ja": "일본어",
        "zh-CN": "중국어 간체",
        "zh-TW": "중국어 번체",
        "vi": "베트남어",
        "id": "인도네시아어",
        "th": "태국어",
        "de": "독일어",
        "ru": "러시아어",
        "es": "스페인어",
        "it": "이탈리아어",
        "fr": "프랑스어"
    ]
    
    static func getLanguageList() -> [String] {
        return listWithCode.values.sorted()
    }
    
    static func getLanguageCode(_ language: String) -> String? {
        for (key, value) in listWithCode {
            if value == language { return key }
        }
        return nil
    }
}

// MARK: - AgeGroup

struct AgeGroup {
    static let list: [String] = ["무관", "20대 초반", "20대 중반", "20대 후반", "30대 초반"]
}

// MARK: - MBTI

struct Mbti {
    static let list: [String] = [
        "ESTJ", "ESTP", "ESFJ", "ESFP",
        "ENTJ", "ENTP", "ENFJ", "ENFP",
        "ISTJ", "ISTP", "ISFJ", "ISFP",
        "INTJ", "INTP", "INFJ", "INFP"
    ]
}

// MARK: - LifeStyle

struct LifeStyle {
    static let list: [[String]] = [
        ["life_morning", "아침형 인간"],
        ["life_night", "올빼미형 인간"]
    ]
}

// MARK: - SchedulePopUp

struct SchedulePopUp {
    static let date = "날짜"
    static let time = "시간"
    static let place = "장소"
    static let people = "인원"
}

// MARK: - MeetingFiltering

struct MeetingFiltering {
    static let searching: String = "나와 잘맞는 모임을 검색해 보세요"
    static let done: String = "완료"
    static let joinStatus: String = "모집 상태"
    static let joinStatusList: [String] = ["모집 중", "모집 완료"]
    static let ageTitle: String = "모집 연령대"
    static let ageList: [String] = ["무관", "20초반", "20중반", "20후반"]
    static let joinNumber: String = "모집 인원"
    static let joinNumberList: [String] = ["개인 모임", "단체 모임"]
    static let interestingTitle: String = "관심 주제 설정"
    static let interestingTopicList: [String] = ["스포츠1", "스포츠2", "스포츠3", "스포츠4", "스포츠5", "스포츠6", "스포츠7", "스포츠8", "스포츠9"]
    static let filterClear: String = " 초기화"
    static let maxSelectionCount = 3
}

// MARK: - MeetingCreatePopUp

struct MeetingCreatePopUp {
    static let description: String = "1인당 모임은 최대 5개까지 생성가능합니다.\n신중하게 만들어 주세요!"
    static let check: String = "확인"
    static let information: String = "더 많은 모임을 만들고 싶다면,\n프리미엄 이용권을 구경해보세요!"
}

// MARK: - Rule

struct Rule {
    static let list: [String] = [
        "해당사항 없음",
        "활동적인 걸 원해요",
        "빠른 답변을 원해요",
        "모임참석이 중요해요",
        "우리 모임에 집중해주길 원해요",
        "욕설 및 비방글 절대 금지",
        "너무 늦은 시간에는 대화 금지",
        "강퇴를 진행할 수 있어요",
        "선정적인 이야기 금지",
        "존댓말로 대화해요",
        "반말로 대화해요",
        "방학 떄도 활동할 사람을 원해요",
        "건전한 모임 활동을 원해요",
        "하루에 한 번 대화는 꼭 참여해요",
        "자유로운 분위기를 원해요"
    ]
}

// MARK: - UserInfo

struct UserInfo {
    static let bornCountry = "출생 국가"
    static let bornCountryPlaceHolder = "출생 국가를 선택해주세요"
    static let college = "대학교 선택"
    static let collegePlaceHolder = "대학교를 선택해주세요"
}

// MARK: - DetailMeetingJoinPopUp

struct DetailMeetingJoinPopUp{
    static let description: String = "모임 가입 여부는 1일 이내로..."
    static let check: String = "접수하기"
}

// MARK: - SelectUniversity

struct SelectUniversity {
    static let years: [String] = ["2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023"]
}

// MARK: - Interest

struct Interest {
    static let listWithIcon: [String] = [
        "⚽️ 스포츠", "📚 독서", "❤️ 연애",
        "🎬 영화", "🐶 반려동물", "🥘 요리",
        "🍽️ 맛집투어", "✈️ 여행", "👕 패션",
        "🎧 음악", "🇺🇸 언어교환", "📸 사진"
    ]
    
    static let list: [String] = [
        "음악", "K-pop", "스포츠", "경기",
        "언어 교환", "언어", "국가", "친목",
        "음식", "요리", "맛집", "카페",
        "공부", "전공", "학점", "독서"
    ]
}

struct Topic {
    static let titleList: [String] = ["음악", "스포츠", "국가", "음식", "공부"]
    
    static let music: [String] = ["좋아하는 음악의 장르를 물어 봐보세요!",
                                  "노래방 가면 자주 부르는 곡이 무엇인가요?",
                                  "같이 노래방 가는 건 어때요?",
                                  "우리 학교 앞 코인 노래방 자주 가봤어요?",
                                  "노래방 가면 자주 부르는 곡이 무엇인가요?",
                                  "상대방 나라에서 유명한 노래를 물어 보세요!",
                                  "좋아하는 가수는 누구인가요?",
                                  "K -POP 가수 중 누굴 제일 좋아하나요?",
                                  "노래를 듣는 걸 좋아하나요? 부르는 걸 좋아하나요?",
                                  "음악 관련 동아리를 하나요?"]
    
    static let sports: [String] = ["좋아하는 스포츠가 무엇인가요?",
                                   "스포츠를 직접 한 경험이 있나요?",
                                   "가장 좋아하는 선수 혹은 팀(구단)이 있나요?",
                                   "학교 체육대회에 참여해 본적 있나요?",
                                   "해외 경기를 좋아하나요? 국내 경기를 좋아하나요?",
                                   "학교 스포츠 동아리를 참여한 적 있나요?",
                                   "스포츠 교양 과목을 수강한 적 있나요?",
                                   "가장 인상 깊게 본 스포츠 경기가 무엇인가요?",
                                   "함께 운동해보면 어떨까요?",
                                   "운동 즐겨하나요?"]
    
    static let country: [String] = ["당신의 국가에서 가장 유명한 건 무엇인가요?",
                                    "친해지고 싶은 나라의 사람이 있나요? 이유는요?",
                                    "대한민국에서 가장 매력적인 장소는 어디인 것 같아요?",
                                    "가보고 싶은 국내 혹은 해외 여행지가 있나요?",
                                    "여행했던 국가 중 가장 좋았던 곳은 어디인가요?",
                                    "다양한 국가의 사람들을 만나본 경험이 있나요?",
                                    "다양한 사람들이랑 함께 모임을 추진해보는 것 어때요?",
                                    "우리 같이 동일한 언어로만 대화를 해보는 것 어때요?"]
    
    static let food: [String] = ["당신의 국가에서 가장 유명한 음식은 무엇인가요?",
                                 "맛집은 줄 서서 기다리는 편인가요?",
                                 "우리 학교 주변 맛집은 어디라고 생각해요? 추천해줘요!",
                                 "자주 가는 카페가 어디인가요? 디저트 좋아해요?",
                                 "혼밥하는 것을 불편해 하진 않나요?",
                                 "못 먹는 음식이 있나요? 그 이유는요?",
                                 "맛집 탐방 경험이 있나요?",
                                 "여태 먹었던 음식 중 가장 맛있었던 음식은 무엇인가요?",
                                 "직접 요리를 해 먹는 편인가요?",
                                 "가장 자신있는 요리는 무엇인가요?"]
    
    static let study: [String] = ["우리 학교로 교환학생 (진학) 온 이유가 무엇인가요?",
                                  "미래에 하고 싶은 직무가 무엇인가요?",
                                  "같이 스터디 진행해볼까요?",
                                  "관심있는 언어는 무엇이고 그 이유는요?",
                                  "공부하면서 받는 스트레스는 어떻게 받는 편인가요?",
                                  "주로 어디에서 공부하나요?" ,
                                  "현재 전공을 선택한 이유가 있나요?",
                                  "우리 학교에서 가장 마음에 드는 장소는 어디인가요?",
                                  "우리 학교 축제 즐긴 적 있나요? 어땠나요?",
                                  "최근 관심있는 분야가 무엇인가요?"]
}
