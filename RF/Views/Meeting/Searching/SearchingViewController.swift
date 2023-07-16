//
//  SearchingViewController.swift
//  RF
//
//  Created by 정호진 on 2023/07/16.
//

import Foundation
import SnapKit
import UIKit
import RxCocoa
import RxSwift

final class SearchingViewController: UIViewController{
    
    /// 검색 버튼
    private lazy var searchBtn: UISearchBar = {
        let btn = UISearchBar()
        btn.placeholder = "모임 이름을 입력해 주세요"
        return btn
    }()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.titleView = searchBtn
        navigationController?.navigationBar.isHidden = false
        moveFilteringScreen()
        
    }
    
    /// MARK: 필터링 화면 이동
    private func moveFilteringScreen(){
        let filteringScreen = FilteringViewController()
        filteringScreen.modalPresentationStyle = .formSheet
        present(filteringScreen, animated: true)
    }
    
    
    
}
