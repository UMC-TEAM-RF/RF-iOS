//
//  ChatService.swift
//  RF
//
//  Created by 이정동 on 2023/08/07.
//

import Foundation
import StompClientLib
import Alamofire

class ChatService {
    static let shared = ChatService()
    private var socketClient: StompClientLib
    
    private init() {
        socketClient = StompClientLib()
    }
    
    // 소켓 연결
    func connect() {
        if socketClient.isConnected() {
            print("Socket is already connected!")
            return
        }
        
        let urlString = "\(Domain.webSocket)\(SocketPath.connect)"
        let url = NSURL(string: urlString)!
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as URL), delegate: self)
    }
    
    /// 채팅방 구독
    /// - Parameter partyId: 내가 가입한 모임 ID
    func subscribe(_ partyId: Int) {
        print(#function, partyId)
        let destination = SocketPath.subscribe
        socketClient.subscribe(destination: "\(destination)/\(partyId)")
    }
    
    /// 입력한 메시지 전달
    /// - Parameter message: 메시지
    func send(message: Message, partyId: Int) {
        let destination = SocketPath.send
        
        guard let object = codableToObject(from: message) else {
            print("Codable To Object is Error")
            return
        }
        socketClient.sendJSONForDict(dict: object, toDestination: "\(destination)/\(partyId)")
    }
    
    /// Codable 타입을 AnyObject 타입으로 변환
    /// - Parameter codableObject: AnyObject로 변환할 Codable 객체
    /// - Returns: AnyObject 타입의 객체
    private func codableToObject<T: Codable>(from codableObject: T) -> AnyObject? {
        do {
            let jsonData = try JSONEncoder().encode(codableObject)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .fragmentsAllowed)
            if let jsonDictionary = jsonObject as? NSDictionary {
                print(jsonDictionary)
                return jsonDictionary
            }
        } catch {
            print("Error converting Codable object to AnyObject: \(error.localizedDescription)")
        }
        return nil
    }
    
    /// AnyObject? 객체 Codable 객체로 변환
    /// - Parameters:
    ///   - object: AnyObject? 객체
    ///   - type: 변환할 Codable.self
    /// - Returns: Codable? 객체
    func decodeFromAnyObject<T: Codable>(_ object: AnyObject?, to type: T.Type) -> T? {
        do {
            // 1. AnyObject?를 JSON 데이터로 변환
            let jsonData = try JSONSerialization.data(withJSONObject: object as Any, options: [])

            // 2. JSON 데이터를 원하는 Codable 객체로 디코딩
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(type, from: jsonData)
            
            return decodedObject
        } catch {
            print("Error decoding object: \(error.localizedDescription)")
            return nil
        }
    }
    
    func subscribeChannel() {
        let channelIds = ChatRepository.shared.getChannelIds()
        channelIds.forEach({
            ChatService.shared.subscribe($0)
        })
    }
}

extension ChatService: StompClientLibDelegate {
    func stompClientDidConnect(client: StompClientLib!) {
        // DB에서 내가 가입한 모임 리스트를 가져와서 각각 구독
        
        subscribeChannel()
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print(#function)
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print(#function)
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print(#function)
    }
    
    func serverDidSendPing() {
        print(#function)
    }
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print(#function)
        
        guard let data = decodeFromAnyObject(jsonBody, to: Message.self) else {
            print("Decode Error")
            return
        }
        
        print(data)
        
        let destination = destination.components(separatedBy: "/").last!
//        let index = SingletonChannel.shared.list.firstIndex { String($0.id) == destination }
//        
//        SingletonChannel.shared.list[index ?? 0].messages.append(data)  // 수신된 메시지 추가
        
        NotificationCenter.default.post(name: NotificationName.updateChatList, object: self)
        NotificationCenter.default.post(name: NotificationName.updateChatRoom, object: self)
    }
}
