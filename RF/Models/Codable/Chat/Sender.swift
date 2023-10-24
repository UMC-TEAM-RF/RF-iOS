//
//  Sender.swift
//  RF
//
//  Created by 이정동 on 2023/09/26.
//

import Foundation

struct Sender: Codable {
    var userId: Int?
    var userName: String?
    var userImageUrl: String?
}

extension Sender {
    func toRealmObject() -> RealmSender {
        return RealmSender(id: self.userId!, name: self.userName!, imgeUrl: self.userImageUrl!)
    }
}
