//
//  UITextField+Rx.swift
//  RxCocoa
//
//  Created by Krunoslav Zaher on 2/21/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if os(iOS) || os(tvOS)

import RxSwift
import UIKit

extension Reactive where Base: UITextField {
    /// Reactive wrapper for `text` property.
    public var text: ControlProperty<String?> {
        value
    }
    
    /// Reactive wrapper for `text` property.
    public var value: ControlProperty<String?> {
        return base.rx.controlPropertyWithDefaultEvents(
            getter: { textView in
                textView.text
            },
            setter: { textView, value in
                // This check is important because setting text value always clears control state
                // including marked text selection which is important for proper input
                // when IME input method is used.
                if textView.text != value {
                    textView.text = value
                }
            }
        )
    }
    
    /// Bindable sink for `attributedText` property.
    public var attributedText: ControlProperty<NSAttributedString?> {
        return base.rx.controlPropertyWithDefaultEvents(
            getter: { textView in
                textView.attributedText
            },
            setter: { textView, value in
                // This check is important because setting text value always clears control state
                // including marked text selection which is important for proper input
                // when IME input method is used.
                if textView.attributedText != value {
                    textView.attributedText = value
                }
            }
        )
    }
}

#endif
