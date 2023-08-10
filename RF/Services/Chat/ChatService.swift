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
        print(#function)
        let destination = SocketPath.subscribe
        socketClient.subscribe(destination: "\(destination)/\(partyId)")
    }
    
    /// 입력한 메시지 전달
    /// - Parameter message: 메시지
    func send(message: CustomMessage, partyId: Int) {
        print(#function)
        
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
}

extension ChatService: StompClientLibDelegate {
    func stompClientDidConnect(client: StompClientLib!) {
        // DB에서 내가 가입한 모임 리스트를 가져와서 각각 구독
        
        subscribe(1)
        subscribe(2)
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
        
        guard let data = decodeFromAnyObject(jsonBody, to: CustomMessage.self) else {
            print("Decode Error")
            return
        }
        
        let destination = destination.components(separatedBy: "/").last!
        let index = SingletonChannel.shared.list.firstIndex { String($0.id) == destination }
        
        SingletonChannel.shared.list[index ?? 0].messages.append(data)  // 수신된 메시지 추가
        
        NotificationCenter.default.post(name: NotificationName.updateChat, object: self)
    }
}


// MARK: - Singleton Channel Model
class SingletonChannel {
    static let shared: SingletonChannel = SingletonChannel()
    private init() {}
    
    var list: [Channel] = [
        Channel(id: 1, name: "1번 모임", messages: [
            CustomMessage(content: "TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST", dateTime: "21:09"),
            CustomMessage(sender: CustomMessageSender(speakerId: 1, speakerName: "JD"), content: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
            CustomMessage(sender: CustomMessageSender(speakerId: 1, speakerName: "JD"), content: "t has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
            CustomMessage(sender: CustomMessageSender(speakerId: 2, speakerName: "망고"), content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout"),
            CustomMessage(sender: CustomMessageSender(speakerId: 3, speakerName: "제이디"), content: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..."),
            CustomMessage(sender: CustomMessageSender(speakerId: 4, speakerName: "만자"), content: "Contrary to popular belief, Lorem Ipsum is not simply random text."),
            CustomMessage(sender: CustomMessageSender(speakerId: 2, speakerName: "망고"), content: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
            CustomMessage(sender: CustomMessageSender(speakerId: 2, speakerName: "망고"), content: "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested."),
            CustomMessage(sender: CustomMessageSender(speakerId: 2, speakerName: "망고"), content: "FC BARCELONA EL CLASICO FRENKIE DE JONG PEDRI GAVI SPAIN LA LIGA"),
            CustomMessage(sender: CustomMessageSender(speakerId: 4, speakerName: "만자"), content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
            CustomMessage(sender: CustomMessageSender(speakerId: 3, speakerName: "제이디"), content: "테스트"),
            CustomMessage(sender: CustomMessageSender(speakerId: 3, speakerName: "제이디"), content: "테스트"),
            CustomMessage(sender: CustomMessageSender(speakerId: 4, speakerName: "만자"), content: "테스트"),
            CustomMessage(sender: CustomMessageSender(speakerId: 4, speakerName: "만자"), content: "테스트"),
            CustomMessage(sender: CustomMessageSender(speakerId: 4, speakerName: "만자"), content: "테스트"),
            CustomMessage(sender: CustomMessageSender(speakerId: 2, speakerName: "망고"), content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout", dateTime: "2023-08-07 21:41:44.889734")
        ], userProfileImages: ["a", "a", "a", "a"]),
        Channel(id: 2, name: "2번 모임", messages: [
            CustomMessage(content: "TESTTESTTESTTESTESTTEST", dateTime: "21:09"),
            CustomMessage(sender: CustomMessageSender(speakerId: 1, speakerName: "JD"), content: "Lorem Ipsum has  type and scrambled it to make a type specimen book."),
            CustomMessage(sender: CustomMessageSender(speakerId: 1, speakerName: "JD"), content: "t has survived not only five centurid."),
            CustomMessage(sender: CustomMessageSender(speakerId: 2, speakerName: "망고"), content: "It is a long established  its layout"),
            CustomMessage(sender: CustomMessageSender(speakerId: 3, speakerName: "제이디"), content: "Neque it..."),
            CustomMessage(sender: CustomMessageSender(speakerId: 4, speakerName: "만자"), content: "Contrary to popular belief, Lorem Ipsum is not simply random text."),
            CustomMessage(sender: CustomMessageSender(speakerId: 2, speakerName: "망고"), content: "There are many varvable."),
            CustomMessage(sender: CustomMessageSender(speakerId: 2, speakerName: "망고"), content: "The standard chunk of Lorem Ipsum ubelow for those interested."),
            CustomMessage(sender: CustomMessageSender(speakerId: 2, speakerName: "망고"), content: "FC BARCELONA EL CLASIE DE JONG PEDRI GAVI SPAIN LA LIGA"),
            CustomMessage(sender: CustomMessageSender(speakerId: 4, speakerName: "만자"), content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
            CustomMessage(sender: CustomMessageSender(speakerId: 3, speakerName: "제이디"), content: "테스트"),
            CustomMessage(sender: CustomMessageSender(speakerId: 3, speakerName: "제이디"), content: "Lorem"),
            CustomMessage(sender: CustomMessageSender(speakerId: 4, speakerName: "만자"), content: "테스트"),
            CustomMessage(sender: CustomMessageSender(speakerId: 4, speakerName: "만자"), content: "dummy"),
            CustomMessage(sender: CustomMessageSender(speakerId: 4, speakerName: "만자"), content: "printing"),
            CustomMessage(sender: CustomMessageSender(speakerId: 2, speakerName: "망고"), content: "It is a longooking at its layout", dateTime: "2023-08-07 21:41:44.889734")
        ], userProfileImages: ["a", "a", "a"])
    ]
    
    /// 채널 리스트에서 특정 채널의 index 위치 가져오기
    /// - Parameter channelId: Channel ID
    /// - Returns: Index(Int)
    func getChannelIndex(_ channelId: Int) -> Int? {
        let index = list.firstIndex { $0.id == channelId }
        return index
    }
    
    /// 특정 채널의 메시지 리스트 가져오기
    /// - Parameter id: Channel ID
    /// - Returns: Messages
    func getChannelMessages(_ id: Int) -> [CustomMessage] {
        let index = list.firstIndex { $0.id == id }
        guard let index else { return [] }
        return list[index].messages
    }
    
    /// 특정 채널에 메시지 추가
    /// - Parameters:
    ///   - channelId: Channel ID
    ///   - message: Message
    func appendMessage(channelId: Int, message: CustomMessage) {
        let index = list.firstIndex { $0.id == channelId }
        guard let index else { return }
        list[index].messages.append(message)
    }
    
    func sortByLatest() {
        list.sort { $0.messages.last?.dateTime ?? "" > $1.messages.last?.dateTime ?? "" }
    }
    
    func readNewMessage(_ channelId: Int) {
        guard let index = getChannelIndex(channelId) else { return }
        var messages = getChannelMessages(channelId)
        
        for i in stride(from: messages.count - 1, through: 0, by: -1) {
            if messages[i].isNew == false { break }
            messages[i].isNew = false
        }
        
        list[index].messages = messages
    }
}
