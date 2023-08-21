//
//  ListCellViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/07/24.
//

import Foundation
import RxRelay
import RxSwift

final class ListCellViewModel {
    
    /// 찜하기 버튼 있는지
    var checkLike: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var userList: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    /// UserList에서 유저 이미지들만 사용
    func changeTypeUserToString(list: [User]){
        var imgList: [String] = []
        
        list.forEach { user in
            imgList.append(user.profileImageUrl ?? "")
        }
        userList.accept(imgList)
    }
    
}
