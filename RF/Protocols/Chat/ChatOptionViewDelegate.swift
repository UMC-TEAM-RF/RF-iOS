//
//  OptionViewDelegate.swift
//  RF
//
//  Created by 이정동 on 10/25/23.
//

import Foundation

@objc protocol ChatOptionViewDelegate: AnyObject {
    @objc optional func createSchedule(title: String, date: String, time: String, place: String)
    @objc optional func didSelectSubject(_ subject: String)
}
