//
//  NSTextField+Rx.swift
//  RxCocoa
//
//  Created by Krunoslav Zaher on 5/17/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if os(macOS)

import Cocoa
import RxSwift

/// Delegate proxy for `NSTextField`.
///
/// For more information take a look at `DelegateProxyType`.
open class RxTextFieldDelegateProxy
    : DelegateProxy<NSTextField, NSTextFieldDelegate>
    , DelegateProxyType 
    , NSTextFieldDelegate {

    /// Typed parent object.
    public weak private(set) var textView: NSTextField?

    /// Initializes `RxTextFieldDelegateProxy`
    ///
    /// - parameter textField: Parent object for delegate proxy.
    init(textView: NSTextField) {
        self.textView = textView
        super.init(parentObject: textView, delegateProxy: RxTextFieldDelegateProxy.self)
    }

    public static func registerKnownImplementations() {
        self.register { RxTextFieldDelegateProxy(textView: $0) }
    }

    fileprivate let textSubject = PublishSubject<String?>()

    // MARK: Delegate methods
    open func controlTextDidChange(_ notification: Notification) {
        let textView: NSTextField = castOrFatalError(notification.object)
        let nextValue = textView.stringValue
        self.textSubject.on(.next(nextValue))
        _forwardToDelegate?.controlTextDidChange?(notification)
    }
    
    // MARK: Delegate proxy methods

    /// For more information take a look at `DelegateProxyType`.
    open class func currentDelegate(for object: ParentObject) -> NSTextFieldDelegate? {
        object.delegate
    }

    /// For more information take a look at `DelegateProxyType`.
    open class func setCurrentDelegate(_ delegate: NSTextFieldDelegate?, to object: ParentObject) {
        object.delegate = delegate
    }
    
}

extension Reactive where Base: NSTextField {

    /// Reactive wrapper for `delegate`.
    ///
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    public var delegate: DelegateProxy<NSTextField, NSTextFieldDelegate> {
        RxTextFieldDelegateProxy.proxy(for: self.base)
    }
    
    /// Reactive wrapper for `text` property.
    public var text: ControlProperty<String?> {
        let delegate = RxTextFieldDelegateProxy.proxy(for: self.base)
        
        let source = Observable.deferred { [weak textView = self.base] in
            delegate.textSubject.startWith(textView?.stringValue)
        }.take(until: self.deallocated)

        let observer = Binder(self.base) { (control, value: String?) in
            control.stringValue = value ?? ""
        }

        return ControlProperty(values: source, valueSink: observer.asObserver())
    }
    
}

#endif
