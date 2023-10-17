//
//  RealmUser.swift
//  RF
//
//  Created by 이정동 on 10/16/23.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    @Persisted var id: Int
    @Persisted var university: String
    @Persisted var nickname: String
    @Persisted var lifeStyle: String
    @Persisted var country: String
    @Persisted var interestingLanguages: List<String>
    @Persisted var interestingCountries: List<String>
    @Persisted var interests: List<String>
    @Persisted var introduce: String
    @Persisted var mbti: String
    @Persisted var entrance: Int
    @Persisted var profileImageUrl: String
    
    convenience init(user: User) {
        self.init()
        self.id = user.userId ?? 0
        self.university = user.university ?? ""
        self.nickname = user.nickname ?? ""
        self.lifeStyle = user.lifeStyle ?? ""
        self.country = user.country ?? ""
        self.introduce = user.introduce ?? ""
        self.mbti = user.mbti ?? ""
        self.entrance = user.entrance ?? 0
        self.profileImageUrl = user.profileImageUrl ?? ""
        self.interests.append(objectsIn: user.interest ?? [])
        self.interestingLanguages.append(objectsIn: user.interestLanguage ?? [])
        self.interestingCountries.append(objectsIn: user.interestCountry ?? [])
    }
}
