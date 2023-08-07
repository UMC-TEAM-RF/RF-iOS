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
    
    func connect() {
        if socketClient.isConnected() { return }
        
        let urlString = "\(Domain.webSocket)\(SocketAPI.connect)"
        let url = NSURL(string: urlString)!
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as URL), delegate: self)
    }
    
    func subscribe(_ partyId: Int) {
        let destination = SocketAPI.subscribe
        socketClient.subscribe(destination: "\(destination)/\(partyId)")
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
        
    }
    
    
}
