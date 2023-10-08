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
    let realm: Realm = try! Realm()
    
    private init() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    /// 새로운 채팅방 채널을 Realm에 추가
    /// - Parameters:
    ///   - id: 모임 ID
    ///   - name: 모임 이름
    func createNewChannel(id: Int, name: String) {
        let channel = RealmChannel(id: id, name: name)
        try! realm.write({
            realm.add(channel)
        })
    }
    
    
}
