//
//  ChatService.swift
//  RF
//
//  Created by 이정동 on 2023/08/07.
//

import Foundation
import StompClientLib

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
        let destination = SocketPath.subscribe
        socketClient.subscribe(destination: "\(destination)/\(partyId)")
    }
    
    /// 입력한 메시지 전달
    /// - Parameter message: 메시지
    func send(message: Message, partyId: Int) {
        let destination = SocketPath.send
        guard let object = codableToObject(from: message) else { print("Codable To Object is Error"); return }
        socketClient.sendJSONForDict(dict: object, toDestination: "\(destination)/\(partyId)")
        
    }
    
    /// Codable 타입을 AnyObject 타입으로 변환
    /// - Parameter codableObject: AnyObject로 변환할 Codable 객체
    /// - Returns: AnyObject 타입의 객체
    private func codableToObject<T: Codable>(from codableObject: T) -> AnyObject? {
        do {
            let jsonData = try JSONEncoder().encode(codableObject)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
            if let jsonDictionary = jsonObject as? NSDictionary {
                return jsonDictionary
            }
        } catch {
            print("Error converting Codable object to AnyObject: \(error.localizedDescription)")
        }
        return nil
    }
}

extension ChatService: StompClientLibDelegate {
    func stompClientDidConnect(client: StompClientLib!) {
        // DB에서 내가 가입한 모임 리스트를 가져와서 각각 구독
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        
    }
    
    func serverDidSendPing() {
        
    }
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        
        print("Received message: \(String(describing: jsonBody))")
    }
    
    
}
