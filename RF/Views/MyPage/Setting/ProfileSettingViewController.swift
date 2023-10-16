//
//  ProfileSettingViewController.swift
//  RF
//
//  Created by 이정동 on 2023/08/01.
//

import UIKit
import SnapKit

class ProfileSettingViewController: UIViewController {
    
    //MARK: - UI Property
    
    
    private lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(settingTableViewCell.self, forCellReuseIdentifier: settingTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = 60
        return tableView
    }()

    let menuList: [String] = ["프리미엄 이용권", "공지사항", "고객센터 / 도움말", "버전 정보", "차단 관리", "회원 탈퇴"]
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        updateTitleView(title: "설정")
        setupCustomBackButton()
        
        addSubviews()
        configureConstraints()
    }
    
    // MARK: - addsubviews()
    private func addSubviews() {
        view.addSubview(menuTableView)
    }

    // MARK: - configureConstraints()
    private func configureConstraints() {
        menuTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ProfileSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: settingTableViewCell.identifier, for: indexPath) as? settingTableViewCell else { return UITableViewCell() }

        cell.updateTitle(menuList[indexPath.row])

        return cell
    }
}
