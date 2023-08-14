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
    
    /// MARK: 필터링 버튼
    private lazy var filteringBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hexCode: "F5F5F5")
        btn.setTitle(MeetingFiltering.searching, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.semanticContentAttribute = .forceRightToLeft
        return btn
    }()
    
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
        view.addSubview(filteringBtn)
        
        configureConstraints()
    }
    
    /// MARK: setting AutoLayout
    private func configureConstraints(){
        filteringBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/20)
        }
        
    }
    
    /// MARK: 버튼들 클릭 했을 때 실행
    private func clickedBtns(){
        filteringBtn.rx.tap
            .bind { [weak self] in
                self?.moveFilteringScreen()
            }
            .disposed(by: disposeBag)
    }
    
}

extension SearchingViewController: UISearchBarDelegate{
    
}
