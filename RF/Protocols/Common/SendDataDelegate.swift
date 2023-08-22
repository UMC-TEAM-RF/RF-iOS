//
//  File.swift
//  RF
//
//  Created by 이정동 on 2023/07/31.
//

import Foundation

@objc protocol SendDataDelegate: AnyObject {
    
    // 이전 화면으로 String 데이터 전달
    @objc optional func sendStringData(_ data: String)
    
    // 이전 화면으로 Bool 데이터 전달
    @objc optional func sendBooleanData(_ data: Bool)
    
    // 이전 화면으로 [String] 데이터 전달
    @objc optional func sendStringArrayData(_ data: [String])
    
    // PickerViewController -> SetDetailInfoViewController
    @objc optional func sendData(tag: Int, data: String)
    
    // PageCollectionViewCell -> HomeViewController
    @objc optional func sendMeetingData(tag: Int, index: Int)
}
