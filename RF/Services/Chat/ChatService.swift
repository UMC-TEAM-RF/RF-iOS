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
        print(#function)
        let destination = SocketPath.subscribe
        socketClient.subscribe(destination: "\(destination)/\(partyId)")
    }
    
    /// 입력한 메시지 전달
    /// - Parameter message: 메시지
    func send(message: Message, partyId: Int) {
        print(#function)
        
        let destination = SocketPath.send
        
        guard let object = codableToObject(from: message) else {
            print("Codable To Object is Error")
            return
        }
        
        socketClient.sendJSONForDict(dict: object, toDestination: "\(destination)/\(partyId)")
    }
    
    func translateMessage(source: String, target: String, text: String, completion: @escaping (String)->()) {
        
        let url = "\(Domain.naverApi)\(PapagoApiPath.translation)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Naver-Client-Id": NaverApiHeaders.clientId,
            "X-Naver-Client-Secret": NaverApiHeaders.clientSecret
        ]
        let params: [String: Any] = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: TranslationData.self) { response in
                switch response.result{
                case .success (let data):
                    completion(data.message.result.translatedText)
                case .failure (let error):
                    print("Translate error!\n\(error)")
                }
            }
    }
    
    func detectLanguage(_ text: String, completion: @escaping (String)->()) {
        let url = "\(Domain.naverApi)\(PapagoApiPath.detectLangs)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Naver-Client-Id": NaverApiHeaders.clientId,
            "X-Naver-Client-Secret": NaverApiHeaders.clientSecret
        ]
        
        let params: [String: Any] = [
            "query": text
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<201)
            .responseDecodable(of: Sensing.self) { response in
                switch response.result{
                case .success (let data):
                    completion(data.langCode)
                case .failure (let error):
                    print("Translate error!\n\(error)")
                }
            }
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
        //subscribe(2)
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
        
        let destination = destination.components(separatedBy: "/").last!
        let index = SingletonChannel.shared.list.firstIndex { String($0.id) == destination }
        
        SingletonChannel.shared.list[index ?? 0].messages.append(data)  // 수신된 메시지 추가
        
        NotificationCenter.default.post(name: NotificationName.updateChatList, object: self)
        NotificationCenter.default.post(name: NotificationName.updateChatRoom, object: self)
        NotificationCenter.default.post(name: NotificationName.updateTabBarIcon, object: self)
    }
}


// MARK: - Singleton Channel Model
class SingletonChannel {
    static let shared: SingletonChannel = SingletonChannel()
    private init() {}
    
    var list: [Channel] = [
        Channel(id: 1, name: "집좋아모임", messages: [
            Message(sender: Sender(userId: 1, userName: "제이디"), content: "Hello!", dateTime: "2023-08-23 13:41:44.889734", langCode: "en", isNew: false),
            Message(sender: Sender(userId: 1, userName: "제이디"), content: "Let's be friends~~", dateTime: "2023-08-23 13:41:53.889734", langCode: "en", isNew: false),
            Message(sender: Sender(userId: 2, userName: "HJ"), content: "반가워요!!", dateTime: "2023-08-23 13:43:13.889734", langCode: "ko", isNew: false),
            Message(sender: Sender(userId: 2, userName: "HJ"), content: "Nice to meet you!!", dateTime: "2023-08-23 13:44:44.889734", langCode: "ko", isNew: false),
            Message(sender: Sender(userId: 1, userName: "제이디"), content: "It's an honor to meet you like this!", dateTime: "2023-08-23 13:47:44.889734", langCode: "en", isNew: false),
            Message(sender: Sender(userId: 2, userName: "HJ"), content: "yeah, me too!!", dateTime: "2023-08-23 13:54:44.889734", langCode: "ko", isNew: false),
            Message(sender: Sender(userId: 3, userName: "노리"), content: "こんにちは! よろしくお願いします！！", dateTime: "2023-08-23 13:58:44.889734", langCode: "ja", isNew: true)
        ], userProfileImages: ["https://rf-aws-bucket.s3.ap-northeast-2.amazonaws.com/userDefault/defaultImage.jpg", "https://rf-aws-bucket.s3.ap-northeast-2.amazonaws.com/userDefault/defaultImage.jpg",
                               "https://rf-aws-bucket.s3.ap-northeast-2.amazonaws.com/userDefault/defaultImage.jpg"]),
//        Channel(id: 2, name: "2번 모임", messages: [
//
//        ], userProfileImages: ["a", "a", "a"])
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
    func getChannelMessages(_ id: Int) -> [Message] {
        let index = list.firstIndex { $0.id == id }
        guard let index else { return [] }
        return list[index].messages
    }
    
    /// 특정 채널에 메시지 추가
    /// - Parameters:
    ///   - channelId: Channel ID
    ///   - message: Message
    func appendMessage(channelId: Int, message: Message) {
        let index = list.firstIndex { $0.id == channelId }
        guard let index else { return }
        list[index].messages.append(message)
    }
    
    func sortByLatest() {
        list.sort { $0.messages.last?.dateTime ?? "" > $1.messages.last?.dateTime ?? "" }
    }
    
    /// 메시지를 모두 읽음 여부로 설정 후 가장 첫 새로운 메시지의 Index를 반환
    /// - Parameter channelId: Channel ID
    /// - Returns: Index
    func readNewMessage(_ channelId: Int) -> Int {
        guard let index = getChannelIndex(channelId) else { return 0 }
        var messages = getChannelMessages(channelId)
        
        // 메시지 비어있으면 index = 0
        if messages.isEmpty { return 0 }
        
        var firstNewMessageIndex = messages.count
        
        // 가장 마지막 메시지가 새로운 메시지가 아닐 경우 마지막 index 리턴
        if messages.last?.isNew == false { return firstNewMessageIndex - 1}
        
        for i in stride(from: messages.count - 1, through: 0, by: -1) {
            if messages[i].isNew == false {
                break
            }
            messages[i].isNew = false
            firstNewMessageIndex -= 1
        }
        
        list[index].messages = messages
        return firstNewMessageIndex
    }
}
