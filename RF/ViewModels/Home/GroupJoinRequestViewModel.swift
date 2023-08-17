//
//  NotiAcceptRejectViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/11.
//

import Foundation
import RxSwift
import RxRelay

final class GroupJoinRequestViewModel {
    
    /// 모임 수락 거절화면 리스트
    var notificationAcceptRejectList: BehaviorRelay<[GroupJoinRequestModel]> = BehaviorRelay(value: [])
    
    
    init(){
        var list: [GroupJoinRequestModel] = []
        list.append(GroupJoinRequestModel(profileImage: "soccer", joinedGroup: "알프1", country: "대한민국1", mbti: "ISFJ"))
        list.append(GroupJoinRequestModel(profileImage: "soccer", joinedGroup: "알프2", country: "대한민국2", mbti: "ESFJ"))
        list.append(GroupJoinRequestModel(profileImage: "rf_logo", joinedGroup: "알프3", country: "대한민국3", mbti: "ISFP"))
        list.append(GroupJoinRequestModel(profileImage: "soccer", joinedGroup: "알프4", country: "대한민국4", mbti: "ESFP"))
        list.append(GroupJoinRequestModel(profileImage: "soccer", joinedGroup: "알프5", country: "대한민국5", mbti: "INFJ"))
        list.append(GroupJoinRequestModel(profileImage: "soccer", joinedGroup: "알프6", country: "대한민국6", mbti: "ENFJ"))
        list.append(GroupJoinRequestModel(profileImage: "soccer", joinedGroup: "알프7", country: "대한민국7", mbti: "ENFP"))
        list.append(GroupJoinRequestModel(profileImage: "soccer", joinedGroup: "알프8", country: "대한민국8", mbti: "INFP"))
        list.append(GroupJoinRequestModel(profileImage: "soccer", joinedGroup: "알프9", country: "대한민국9", mbti: "INTP"))
        list.append(GroupJoinRequestModel(profileImage: "soccer", joinedGroup: "알프10", country: "대한민국10", mbti: "ENTP"))
        
        notificationAcceptRejectList.accept(list)
    }
}
