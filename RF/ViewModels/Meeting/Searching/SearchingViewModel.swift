//
//  SearchingViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/15.
//

import Foundation
import RxSwift
import RxRelay

final class SearchingViewModel {
    
    /// searching meeting result List
    var meetingList: BehaviorRelay<[Meeting]> = BehaviorRelay(value: [])
    
    
    // MARK: - API Connect
    
    /// MARK:
    func getData(){
        var list: [Meeting] = []
        
        
        list.append(Meeting(name: "짜장 미친자 모임",
                            memberCount: 5,
                            nativeCount: 2,
                            interests: [ "FOOD", "CAFE", "COUNTRY"],
                            content: "짜장 같이먹어요!",
                            rule: ["a","b","c"],
                            preferAges: "EARLY_TWENTIES",
                            language:  "KOREAN",
                            location: "인하대학교 후문",
                            tag: "aa",
                            ownerId: 1,
                            imageFilePath: "soccer",
                            users: []))
        list.append(Meeting(name: "짜장 미친자 모임",
                            memberCount: 5,
                            nativeCount: 2,
                            interests: [ "FOOD", "CAFE", "COUNTRY"],
                            content: "짜장 같이먹어요!",
                            rule: ["a","b","c"],
                            preferAges: "EARLY_TWENTIES",
                            language:  "KOREAN",
                            location: "인하대학교 후문",
                            tag: "aa",
                            ownerId: 1,
                            imageFilePath: "soccer",
                            users: []))
        list.append(Meeting(name: "짜장 미친자 모임",
                            memberCount: 5,
                            nativeCount: 2,
                            interests: [ "FOOD", "CAFE", "COUNTRY"],
                            content: "짜장 같이먹어요!짜장 같이먹어요!짜장 같이먹어요!짜장 같이먹어요!짜장 같이먹어요!짜장 같이먹어요!짜장 같이먹어요!짜장 같이먹어요!짜장 같이먹어요!짜장 같이먹어요!짜장 같이먹어요!짜장 같이먹어요!짜장 같이먹어요!짜장 같이먹어요!짜장 같이먹어요!",
                            rule: ["a","b","c"],
                            preferAges: "EARLY_TWENTIES",
                            language:  "KOREAN",
                            location: "인하대학교 후문",
                            tag: "aa",
                            ownerId: 1,
                            imageFilePath: "soccer",
                            users: []))
        list.append(Meeting(name: "짜장 미친자 모임",
                            memberCount: 5,
                            nativeCount: 2,
                            interests: [ "FOOD", "CAFE", "COUNTRY"],
                            content: "짜장 같이먹어요!",
                            rule: ["a","b","c"],
                            preferAges: "EARLY_TWENTIES",
                            language:  "KOREAN",
                            location: "인하대학교 후문",
                            tag: "aa",
                            ownerId: 1,
                            imageFilePath: "soccer",
                            users: []))
        
        meetingList.accept(list)
    }
    
}
