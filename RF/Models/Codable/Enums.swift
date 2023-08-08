//
//  Enums.swift
//  RF
//
//  Created by 정호진 on 2023/08/08.
//

import Foundation
import RxSwift
import RxRelay

final class EnumFile {
    static let enumfile = EnumFile()
    private init() {}
    private let service = EnumService()
    private let disposeBag = DisposeBag()

    var enumList: BehaviorRelay<Enums> = BehaviorRelay(value: Enums())
    
    
    /// 초기 데이터 가져오는 함수
    func getEnumList() {
        service.getEnumList()
            .subscribe(
                onNext: { [weak self] data in
                    self?.enumList.accept(data)
                },onError: { error in
                    print("EnumFile getEnumList error!")
                })
            .disposed(by: disposeBag)
        
    }
    
}

struct Enums: Codable {
    var country, interest, language, lifeStyle: [KVO]?
    var mbti, preferAges, rule, university: [KVO]?

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case interest = "Interest"
        case language = "Language"
        case lifeStyle = "LifeStyle"
        case mbti = "Mbti"
        case preferAges = "PreferAges"
        case rule = "Rule"
        case university = "University"
    }
}

struct KVO: Codable, Hashable {
    var key, value: String?
}
