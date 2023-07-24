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
    
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
}
