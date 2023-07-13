//
//  NavigationBarDelegate.swift
//  RF
//
//  Created by 이정동 on 2023/07/10.
//

import Foundation


// Custom Navigation Bar에서 사용할 Delegate 패턴
protocol NavigationBarDelegate: AnyObject {
    func backButtonTapped() // 뒤로 가기 버튼 클릭
}
