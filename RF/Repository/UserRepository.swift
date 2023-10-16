//
//  UserRepository.swift
//  RF
//
//  Created by 이정동 on 10/16/23.
//

import Foundation
import RealmSwift

class UserRepository {
    static let shared = UserRepository()
    private let realm: Realm
    
    private init() {
        realm = try! Realm()
    }
    
    /// 로그인 유저의 정보를 저장
    /// - Parameter user: 서버로부터 받은 유저 정보
    func createUser(user: User) {
        let realmUser = RealmUser(user: user)
        try! realm.write({
            realm.add(realmUser)
        })
    }
    
    /// 로그인 유저 정보 삭제
    func deleteUser() {
        let user = realm.objects(RealmUser.self)
        try! realm.write({
            realm.delete(user)
        })
    }
}
