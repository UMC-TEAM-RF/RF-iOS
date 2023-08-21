//
//  ListViewController.swift
//  RF
//
//  Created by 정호진 on 2023/07/24.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

// MARK: 모임 목록 리스트
final class ListViewController: UIViewController{
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "모임 목록", style: .done, target: self, action: nil)
        btn.isEnabled = false
        btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .disabled)
        return btn
    }()
    
    /// MARK: 목록 나타낼 테이블 뷰
    private lazy var listTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .singleLine
        return table
    }()
    
    private let viewModel = ListViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        getData()
    }
    
    // MARK: View will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = .black
    }
    
    /// MARK: add UI
    private func addSubviews(){
        view.addSubview(listTableView)
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        
        configureConstraints()
    }
    
    /// MARK: setting AutoLayout
    private func configureConstraints(){
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    /// MARK: 모임 목록 리스트 가져오는 함수
    private func getData(){
        viewModel.getData(check: true)
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        let data = viewModel.meetingListRelay.value[indexPath.row]
        
        cell.inputData(imageList: viewModel.meetingListRelay.value[indexPath.row].users,
                       meetingName: data.name ?? "",
                       introduce: data.content ?? "",
                       country: data.language,
                       like: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        /// 삭제 버튼
        let delete = UIContextualAction(style: .destructive, title: "삭제"){ [weak self] action, view, handler in
            guard let cell = tableView.cellForRow(at: indexPath) as? ListTableViewCell else { return }
            self?.viewModel.removeElement(index: indexPath.row)
            cell.removeCellLayout()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        delete.backgroundColor = UIColor(hexCode: "F0EEEE")
        
//        if let like = viewModel.meetingListRelay.value[indexPath.row].like, like{
//            delete.title = "탈퇴"
//        }
        
        /// 신고 버튼
        let report = UIContextualAction(style: .normal, title: "신고"){ action, view, handler in
            print("report Actions")
        }
        report.backgroundColor = UIColor(hexCode: "D9D9D9")
        
        return UISwipeActionsConfiguration(actions: [delete, report])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return tableView.frame.height/9 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return viewModel.meetingListRelay.value.count }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.height // 스크롤뷰의 전체 높이
        let contentSizeHeight = scrollView.contentSize.height // 전체 콘텐츠 영역의 높이
        let offset = scrollView.contentOffset.y // 클릭 위치
        let reachedBottom = (offset > contentSizeHeight - height) // (클릭 지점 + 스크롤뷰 높이 == 전체 컨텐츠 높이) -> Bool
        
        if reachedBottom { // 스크롤이 바닥에 닿았다면 서버에 추가 데이터 요청
            viewModel.getData(check: false)
            
        }
    }
    
}
