//
//  MessageTableViewCellDelegate.swift
//  RF
//
//  Created by 이정동 on 10/17/23.
//

import Foundation
import UIKit

protocol MessageTableViewCellDelegate: AnyObject {
    func longPressedMessageView(_ gesture: UILongPressGestureRecognizer)
    func convertMessage(_ indexPath: IndexPath)
}
