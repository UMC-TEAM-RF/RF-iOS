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
    static let updateChat = NSNotification.Name("UpdateChat")  // 채팅 업데이트
}
