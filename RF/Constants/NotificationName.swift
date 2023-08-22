//
//  NotificationName.swift
//  RF
//
//  Created by 이정동 on 2023/08/08.
//

import Foundation
import UIKit

struct NotificationName {
    static let keyboardWillShow = UIResponder.keyboardWillShowNotification  // 키보드 보임
    static let keyboardWillHide = UIResponder.keyboardWillHideNotification  // 키보드 숨김
    static let updateChatList = NSNotification.Name("UpdateChatList")  // 채팅 업데이트
    static let updateChatRoom = NSNotification.Name("UpdateChatRoom")
    static let updateTabBarIcon = NSNotification.Name("UpdateTabBarIcon")
    static let updateSelectedIndex = NSNotification.Name("UpdateSelectedIndex")
}
