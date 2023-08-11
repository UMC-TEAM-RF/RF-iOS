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
        
        updateTitleView(title: "알림")
        setupCustomBackButton()

        addSubviews()
        configureConstraints()
    }
    
    // MARK: - viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(notiListTableView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        
        notiListTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let notiAcceptRejectViewController = NotiAcceptRejectViewController()
        notiAcceptRejectViewController.titleRelay.accept(dummy[indexPath.row])  // 알림에 대한 모임 이름 넣으면 됨
        navigationItem.backButtonTitle = " "
        navigationController?.pushViewController(notiAcceptRejectViewController, animated: true)
        
    }
}


