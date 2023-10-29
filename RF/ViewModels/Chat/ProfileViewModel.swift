//
//  goodBadViewModel.swift
//  RF
//
//  Created by 용용이 on 10/30/23.
//

import Foundation
import RxSwift
import RxRelay

final class ProfileViewModel{
    
    // 유저 정보 - 단일 데이터 리스트 (리스트로 해야 초기화 작업이 원활해서)
    var userRelay: BehaviorRelay<[User]> = BehaviorRelay<[User]>(value: [])
    
    /// 선택한 라이프 스타일
    var goodBadRelay: BehaviorRelay<IndexPath> = BehaviorRelay<IndexPath>(value: IndexPath())
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Logic
    
    /// MARK: 라이프 스타일 선택
    func selectedgoodBadItem(at: IndexPath){
        var selectItem = goodBadRelay.value
        
        if selectItem == at{
            selectItem = IndexPath()
        }
        else{
            selectItem = at
        }
        
        print("selected good-Bad IndexPath:  \(selectItem)")
        goodBadRelay.accept(selectItem)
    }
    
    ///  버튼 색상 변경하기 위해 사용되는 함수
    func checkSelectedForButtonColor() -> Observable<Bool>{
        let goodBad = goodBadRelay.map { $0 != IndexPath() ? true: false }
        
        return Observable.create { [weak self] observer in
            goodBad.subscribe(onNext: { check in
                observer.onNext(check)
            })
            .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
    }
    
    
    /// 테스트 데이터 넣어 놓은 함수
    func getData() {
        var user : [User] = []
        
        user.append(User(loginId: nil, password: nil, university: "TUKOREA", nickname: "HJ", email: "hojin0309@tukorea.ac.kr", lifeStyle: "OWL_HUMAN", entrance: 2018, country: "KOREA", introduce: "집 보줘ㅠ", interestLanguage: ["ENGLISH", "JAPANESE"], interestCountry: ["UNITED_STATES", "JAPAN"], interest: ["KPOP", "HOT_PLACE", "MUSIC"], mbti: "ISFJ", profileImageUrl: "https://rf-aws-bucket.s3.ap-northeast-2.amazonaws.com/userDefault/defaultImage.jpg", userId: 2))
        
//        user.append(User(loginId: nil, password: nil, university: "TUKOREA", nickname: "노리", email: "yxin@inha.edu", lifeStyle: "MORNING_HUMAN", entrance: 2020, country: "KOREA", introduce: "집이좋아", interestLanguage: ["ENGLISH", "JAPANESE"], interestCountry: ["UNITED_STATES"], interest: ["KPOP", "MUSIC"], mbti: "ISFP", profileImageUrl: "https://rf-aws-bucket.s3.ap-northeast-2.amazonaws.com/userDefault/defaultImage.jpg", userId: 3))
        
        self.userRelay.accept(user)
    }
}
