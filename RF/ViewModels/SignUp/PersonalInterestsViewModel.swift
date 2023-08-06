//
//  PersonalInterestsViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation
import RxSwift
import RxRelay

final class PersonalInterestsViewModel{
    
    /// 선택한 라이프 스타일
    var lifeStyleRelay: BehaviorRelay<IndexPath> = BehaviorRelay<IndexPath>(value: IndexPath())
    
    /// 취미 관심사
    var interestingRelay: BehaviorRelay<Set<IndexPath>> = BehaviorRelay<Set<IndexPath>>(value: [])
    
    /// MBTI
    var mbtiRelay: BehaviorRelay<IndexPath> = BehaviorRelay<IndexPath>(value: IndexPath())
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Logic
    
    /// MARK: 라이프 스타일 선택
    func selectedLifeStyleItem(at: IndexPath){
        var selectItem = lifeStyleRelay.value
        
        if selectItem == at{
            selectItem = IndexPath()
        }
        else{
            selectItem = at
        }
        
        print("selected life Style IndexPath:  \(selectItem)")
        lifeStyleRelay.accept(selectItem)
    }
    
    /// MARK: interesting CollectionView에서 셀 선택했을 때 실행
    func selectedInterestingItems(at indexPath: IndexPath) {
        var selectedItems = interestingRelay.value
        
        if selectedItems.contains(indexPath) {
            selectedItems.remove(indexPath)
            print("deselected interesting \(Interest.list[indexPath.item])")
        }
        else if selectedItems.count < 3 {
            selectedItems.insert(indexPath)
            print("selected interesting \(Interest.list[indexPath.item])")
        }
        else {
            return
        }
        interestingRelay.accept(selectedItems)
    }
    
    /// MARK: MBTI CollectionView에서 셀 선택했을 때 실행
    func selectedMBTIItems(at indexPath: IndexPath) {
        var selectItem = mbtiRelay.value
        
        if selectItem == indexPath{
            selectItem = IndexPath()
        }
        else{
            selectItem = indexPath
        }
        
        print("selected life Style IndexPath:  \(selectItem)")
        mbtiRelay.accept(selectItem)
    }
    
    /// 모두 다 선택 했는지 확인하는 함수
    func checkSelected() -> Observable<Bool>{
        let mbti = mbtiRelay.value != IndexPath() ? true : false
        let style = lifeStyleRelay.value != IndexPath() ? true : false
        let interesting = interestingRelay.value.count == 3 ? true : false
        
        return Observable.create { observer in
            
            if mbti && style && interesting {
                observer.onNext(true)
            }
            else{
                observer.onNext(false)
            }
            
            return Disposables.create()
        }
    }
    
    /// 모두 다 선택 했는지 확인하는 함수
    ///  버튼 색상 변경하기 위해 사용되는 함수
    func checkSelectedForButtonColor() -> Observable<Bool>{
        let mbti = mbtiRelay.map { $0 != IndexPath() ? true: false }
        let style = lifeStyleRelay.map { $0 != IndexPath() ? true: false }
        let interesting = interestingRelay.map { $0.count == 3 ? true : false }
        
        return Observable.create { [weak self] observer in
            Observable.combineLatest(mbti,
                                     style,
                                     interesting,
                                     resultSelector: { mbti, style, interesting in
                mbti && style && interesting
            })
            .subscribe(onNext: { check in
                observer.onNext(check)
            })
            .disposed(by: self?.disposeBag ?? DisposeBag())
            
            return Disposables.create()
        }
    }
    
    /// 취미 관심사 IndexPath -> String value
    func convertInterestingValue() -> Observable<[String]>{
        let list = interestingRelay.value
        var convertList: [String] = []
        
        let _ = list.map { indexPath in
            convertList.append(Interest.list[indexPath.row])
        }
        return Observable.create { observer in
            
            observer.onNext(convertList)
            
            return Disposables.create()
        }
    }
}
