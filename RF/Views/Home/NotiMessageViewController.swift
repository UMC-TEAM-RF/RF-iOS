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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotiListTableViewCell.identifier, for: indexPath) as? NotiListTableViewCell else { return UITableViewCell() }
        
        cell.notiLabelText = "알프에 오신 걸 환영합니다! 프로필 이미지를 변경해 보는 것은 어떨까요?"
        cell.timeLabelText = nil
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let notiAcceptRejectViewController = GroupJoinRequestViewController()
//        notiAcceptRejectViewController.titleRelay.accept(dummy[indexPath.row])  // 알림에 대한 모임 이름 넣으면 됨
//        navigationItem.backButtonTitle = " "
//        navigationController?.pushViewController(notiAcceptRejectViewController, animated: true)
        
    }
}


