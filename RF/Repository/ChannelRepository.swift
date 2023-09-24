//
//  ChannelRepository.swift
//  RF
//
//  Created by 이정동 on 2023/09/25.
//

import Foundation
import RealmSwift

class ChannelRepository {
    static let shared = ChannelRepository()
    private init() {}
    
    let realm = try! Realm()
}
