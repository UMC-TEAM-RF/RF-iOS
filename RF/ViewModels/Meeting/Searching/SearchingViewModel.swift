//
//  SearchingViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/15.
//

import Foundation
import RxSwift
import RxRelay

final class SearchingViewModel {
    
    /// 선택된 관심 주제 목록
    var interestingTopicRelay = BehaviorRelay<Set<IndexPath>>(value: [])
    
    /// 선택한 연령 대
    var ageRelay = BehaviorRelay<IndexPath>(value: IndexPath())
    
    /// 모집 상태
    var joinStatusRelay = BehaviorRelay<IndexPath>(value: IndexPath())
    
    /// 모집 인원
    var joinNumberRelay = BehaviorRelay<IndexPath>(value: IndexPath())
    
    ///  검색 단어
    var searchWord: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    /// searching meeting result List
    var meetingList: BehaviorRelay<[Meeting]> = BehaviorRelay(value: [])
    
    var check: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private let service = SearchService()
    private let disposeBag = DisposeBag()
    
    // MARK: - API Connect
    
    /// MARK: 검색 결과 가져옴
    func getData(){
        var isRecruiting: Bool?
        if joinStatusRelay.value != IndexPath() {
            switch joinStatusRelay.value.row {
            case 0:
                isRecruiting = true
            case 1:
                isRecruiting = false
            default:
                print("none")
            }
        }
        
        let enumFile = EnumFile.enumfile.enumList.value
        var age: String?
        if ageRelay.value != IndexPath() {
            age = enumFile.preferAges?[ageRelay.value.row].key
        }
        
        var num: Int?
        if joinNumberRelay.value != IndexPath() {
            num = joinNumberRelay.value.row
        }
        
        var interests: String?
        var interestsList: [String] = []
        
        if !interestingTopicRelay.value.isEmpty{
            
            interestingTopicRelay.value.forEach { index in
                interestsList.append(enumFile.interest?[index.row].key ?? "")
            }
            interests = interestsList.joined(separator: ",")
        }
        
        
        
        
        service.searchingService(name: searchWord.value,
                                 isRecruiting: isRecruiting,
                                 age: age,
                                 num: num,
                                 interests: interests)
        .subscribe(
            onNext:{ [weak self] list in
                self?.meetingList.accept(list.content ?? [])
                self?.check.accept(true)
            },onError: { error in
                print("searchingService error!\n \(error)")
            })
        .disposed(by: disposeBag)
    }
    
}
