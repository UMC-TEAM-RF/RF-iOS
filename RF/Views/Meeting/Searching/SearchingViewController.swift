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

/// MARK: 모임 검색하는 화면
final class SearchingViewController: UIViewController{
    
    /// MARK: 검색 버튼
    private lazy var searchBtn: UISearchBar = {
        let btn = UISearchBar()
        btn.placeholder = "모임 이름을 입력해 주세요"
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = false
        
        moveFilteringScreen()
        addSubviews()
        clickedBtns()
    }
    
    /// MARK: 필터링 화면 이동
    private func moveFilteringScreen(){
        let filteringScreen = FilteringViewController()
        filteringScreen.modalPresentationStyle = .formSheet
        present(filteringScreen, animated: true)
    }
    
    /// MARK: add UI
    private func addSubviews(){
        navigationItem.titleView = searchBtn
        searchBtn.delegate = self
        
        
        configureConstraints()
    }
    
    /// MARK: setting AutoLayout
    private func configureConstraints(){
      
        
    }
    
    /// MARK: 버튼들 클릭 했을 때 실행
    private func clickedBtns(){
     
    }
    
}

extension SearchingViewController: UISearchBarDelegate{
    
}
