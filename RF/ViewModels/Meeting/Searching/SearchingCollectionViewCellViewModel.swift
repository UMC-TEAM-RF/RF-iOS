//
//  SearchingCollectionViewCellViewModel.swift
//  RF
//
//  Created by 정호진 on 2023/08/15.
//

import Foundation
import RxSwift
import RxRelay

final class SearchingCollectionViewCellViewModel {
    
    /// tag list
    var tagList: BehaviorRelay<[String]> = BehaviorRelay(value: [])
}
