//
//  NotiMessageViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/21.
//

import UIKit
import SnapKit

class NotiMessageViewController: UIViewController {

    // MARK: - UI Property
    
    private lazy var navigationBar: CustomNavigationBar = {
        let bar = CustomNavigationBar()
        bar.delegate = self
        bar.buttonText = "알림"
        return bar
    }()
    
    private lazy var notiListTableView: UITableView = {
        let tb = UITableView()
        tb.dataSource = self
        tb.delegate = self
        tb.register(NotiListTableViewCell.self, forCellReuseIdentifier: NotiListTableViewCell.identifier)
        tb.rowHeight = 70
        tb.separatorStyle = .none
        return tb
    }()
    
    // MARK: - Property
    
    let dummy: [String] = [
        "kimhim 님이 '마라탕 맛집 탐방'에 참여하기를 원해요!",
        "ljdongz 님이 '디천: 디자인 천재들 모임'에 참여하기를 원해요!",
    ]
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        addSubviews()
        configureConstraints()
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(navigationBar)
        view.addSubview(notiListTableView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        navigationBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        notiListTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

// MARK: - Ext: NavigationBarDelegate

extension NotiMessageViewController: NavigationBarDelegate {
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Ext: TableView

extension NotiMessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotiListTableViewCell.identifier, for: indexPath) as? NotiListTableViewCell else { return UITableViewCell() }
        
        cell.notiLabelText = dummy[indexPath.row]
        cell.timeLabelText = "23시간"
        
        return cell
    }
}


