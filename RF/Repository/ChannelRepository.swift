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
        
        // realm에 추가
        try! realm.write({
            realm.add(channel)
        })
    }
    
    /// 모든 채팅방 채널 ID 가져오기
    /// - Returns: [채팅방 채널 ID]
    func getChannelIds() -> [Int] {
        let channels = realm.objects(RealmChannel.self)
        return channels.map({ $0.id })
    }
    
    // MARK: - 각 채널 별 읽지 않은 메시지 개수 분리 필요
    /// 읽지 않은 메시지 개수 가져오기
    /// - Returns: 읽지 않은 메시지 개수
    func getNewMessageCount() -> Int {
        let messages = realm.objects(RealmMessage.self)
        let count = messages.where({ $0.isNew == true }).count
        
        return count
    }
    
    /// 특정 채팅방 채널 새 메시지 읽음 처리
    /// - Parameter id: 채팅방(모임) 채널 ID
    func readNewMessages(id: Int) {
        // 채팅방 채널 가져오기
        guard let channel = realm.object(ofType: RealmChannel.self, forPrimaryKey: id) else {
            print("Do not find RealmChannel Object")
            return
        }
        
        // 읽지 않은 메시지 리스트 가져오기
        let messages = channel.messages.filter({ $0.isNew == true })
        
        messages.forEach({ message in
            // 메시지 읽음 처리
            try! realm.write({
                message.isNew = false
            })
        })
    }
    
    /// 특정 채널의 모든 메시지 가져오기
    /// - Parameter id: 채팅방(모임) 채널 ID
    /// - Returns: [메시지]
    func getChannelMessages(id: Int) -> [RealmMessage] {
        guard let channel = realm.object(ofType: RealmChannel.self, forPrimaryKey: id) else { return [] }
        
        return Array(channel.messages)
    }
    
    // 기존 채팅방 삭제 (채팅방 삭제 전 채팅방과 연결된 realmObject 같이 삭제)
    /// 특정 채팅방 채널 삭제
    /// - Parameter id: 채팅방(모임) 채널 ID
    func deleteChannel(id: Int) {
        // 채널 가져오기
        guard let channel = realm.object(ofType: RealmChannel.self, forPrimaryKey: id) else { return }
        
        try! realm.write({
            // 채널 내 모든 메시지의 speaker, victim, schedule 데이터 삭제
            channel.messages.forEach({ message in
                if let speaker = message.speaker { realm.delete(speaker) }
                if let victim = message.victim { realm.delete(victim) }
                if let schedule = message.schedule { realm.delete(schedule) }
            })
            
            realm.delete(channel.messages) // 채널 메시지 삭제
            realm.delete(channel) // 채널 삭제
        })
    }
    
    /// 채팅 채널에 새 메시지 추가
    /// - Parameters:
    ///   - id: 채팅방(모임) ID
    ///   - message: Message 객체
    func apppendNewMessage(id: Int, message: Message) {
        let message = message.toRealmObject()
        let channel = realm.object(ofType: RealmChannel.self, forPrimaryKey: id) // 채팅방 채널 가져오기

        // 채널에 메시지 추가
        try! realm.write({
            channel?.messages.append(message)
        })
    }
    
    
    // MARK: - 채팅방 목록 화면에 가져올 데이터 함수 정의 필요
    // 모든 채널 정보 가져오기 (채널 정보 + 마지막 메시지 + 각 채널 별 읽지 않은 메시지 개수)
}
