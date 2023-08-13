//
//  ClickedAcceptRejectDelegate.swift
//  RF
//
//  Created by 정호진 on 2023/08/13.
//

import Foundation

@objc
protocol ClickedAcceptRejectDelegate{
    
    /// 거절 버튼 눌렀을 때
    @objc
    func clickedReject(_ indexPath: IndexPath)
    
    /// 수락 버튼 눌렀을 때
    @objc
    func clickedAccept(_ indexPath: IndexPath)
}

