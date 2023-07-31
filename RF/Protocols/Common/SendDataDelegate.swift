//
//  File.swift
//  RF
//
//  Created by 이정동 on 2023/07/31.
//

import Foundation

@objc protocol SendDataDelegate: AnyObject {
    
    // 이전 화면으로 String 데이터 전달
    @objc optional func sendData(_ data: String)
    
    // PickerViewController -> SetDetailInfoViewController
    @objc optional func sendData(tag: Int, data: String)
}
