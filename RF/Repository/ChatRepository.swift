//
//  ChannelRepository.swift
//  RF
//
//  Created by 이정동 on 2023/09/25.
//

import Foundation
import RealmSwift

class ChatRepository {
    static let shared = ChatRepository()
    private let realm: Realm
    
    private init() {
        realm = try! Realm()
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
    
    /// 읽지 않은 모든 메시지 개수 가져오기
    /// - Returns: 읽지 않은 메시지 개수
    func getNewMessageCount() -> Int {
        let messages = realm.objects(RealmMessage.self)
        let count = messages.where({ $0.isNew == true }).count
        
        return count
    }
    
    /// 특정 채널의 읽지 않은 메시지 개수 가져오기
    /// - Parameter id: 채팅방(모임) 채널 ID
    /// - Returns: 읽지 않은 메시지 개수
    func getNewMessageCount(_ id: Int) -> Int {
        guard let channel = realm.object(ofType: RealmChannel.self, forPrimaryKey: id) else { return 0 }
        let count = channel.messages.filter({ $0.isNew == true }).count
        return count
    }
    
    /// 특정 채널의 모든 메시지 가져오기
    /// - Parameter id: 채팅방(모임) 채널 ID
    /// - Returns: [메시지]
    func getChannelMessages(id: Int) -> [RealmMessage] {
        guard let channel = realm.object(ofType: RealmChannel.self, forPrimaryKey: id) else { return [] }
        
        return Array(channel.messages)
    }
    
    // MARK: - <<<Test 필요>>>
    /// 페이지네이션을 이용하여 최근 메시지 가져오기
    /// - Parameters:
    ///   - id: 채팅방(모임) 채널 ID
    ///   - page: 페이지
    /// - Returns: [메시지]
    //    func getChannelMessagesByPage(id: Int, page: Int) -> [RealmMessage] {
    //        guard let channel = realm.object(ofType: RealmChannel.self, forPrimaryKey: id) else { return [] }
    //        let messageCount = channel.messages.count
    //        let startIndex = messageCount - (30 * page - 1) > 0 ? messageCount - (30 * page - 1) : 0
    //        let messages = Array(channel.messages[startIndex..<messageCount])
    //        return messages
    //    }
    
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
            channel?.lastMessageDateTime = message.dateTime
        })
    }
    
    /// 모든 채팅방 리스트 가져오기
    /// - Returns: [채팅 채널]
    func getAllChannel() -> Results<RealmChannel> {
        let channels = realm.objects(RealmChannel.self)
        let sortedChannels = channels.sorted(by: \.lastMessageDateTime, ascending: false)
        return sortedChannels
    }
    
    /// 특정 채널의 읽지 않은 메시지 모두 읽음 처리
    /// - Parameter channelId: 채널 ID
    /// - Returns: 가장 첫 번째의 읽지 않은 메시지 인덱스 위치
    func readNewMessages(_ channelId: Int) -> Int? {
        guard let channel = realm.object(ofType: RealmChannel.self, forPrimaryKey: channelId) else { return nil }
        
        // 메시지가 존재하지 않을 때
        if channel.messages.isEmpty { return nil }
        
        // 마지막 메시지가 읽음 처리 된 경우 마지막 메시지 인덱스 반환
        if channel.messages.last?.isNew == false { return channel.messages.count - 1}
        
        // 첫 읽지 않은 메시지의 인덱스 위치
        let index = channel.messages.firstIndex { $0.isNew == true }
        
        // 읽지 않은 메시지 리스트 가져오기
        let messages = channel.messages.filter({ $0.isNew == true })
        
        messages.forEach({ message in
            // 메시지 읽음 처리
            try! realm.write({
                message.isNew = false
            })
        })
        
        return index
    }
    
    /// 번역된 텍스트를 DB에 저장
    /// - Parameters:
    ///   - messageId: 메시지 ID
    ///   - content: 번역된 텍스트
    func addTranslatedContent(message: RealmMessage, content: String) {
        try! realm.write({
            message.translatedContent = content
            message.isTranslated = true
        })
    }
    
    /// 특정 채널을 가져옴 (채팅방에서 채팅 메시지 업데이트할 때 사용됨)
    /// - Parameter id: 채널 ID
    /// - Returns: 채널 데이터
    func getChannel(_ id: Int) -> RealmChannel? {
        let channel = realm.object(ofType: RealmChannel.self, forPrimaryKey: id)
        return channel
    }
    
    func toggleIsTranslated(message: RealmMessage) {
        try! realm.write({
            message.isTranslated.toggle()
        })
    }
}
