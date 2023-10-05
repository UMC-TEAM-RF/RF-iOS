//
//  RealmSender.swift
//  RF
//
//  Created by 이정동 on 2023/09/26.
//

import Foundation
import RealmSwift

class RealmSender: Object {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var imgeUrl: String
    
    convenience init(id: Int, name: String, imgeUrl: String) {
        self.init()
        self.id = id
        self.name = name
        self.imgeUrl = imgeUrl
    }
}
