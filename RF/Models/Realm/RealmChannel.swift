//
//  RealmChannel.swift
//  RF
//
//  Created by 이정동 on 2023/09/26.
//

import Foundation
import RealmSwift

class RealmChannel: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var messages = List<RealmMessage>()
    @Persisted var lastMessageDateTime: String = ""
    @Persisted var isAlert: Bool = true
    
    convenience init(id: Int, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}
