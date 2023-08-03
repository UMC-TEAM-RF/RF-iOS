//
//  UITextField+Ext.swift
//  RF
//
//  Created by 이정동 on 2023/07/10.
//

import Foundation
import UIKit

extension UITextField {
    
    // textField 왼쪽에 padding을 넣어줌
    func addHorizontalPadding(_ width: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
}
