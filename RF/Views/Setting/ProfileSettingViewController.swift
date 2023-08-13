
//  ProfileSettingViewController
//  ProfileSettingViewController.swift
//  RF
//
//  Created by 이정동 on 2023/08/01.
//

import UIKit
import SnapKit

class ProfileSettingViewController: UIViewController {
    
    //MARK: - UI Property UI구성
    
    
    private lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileSettingTableViewCell.self, forCellReuseIdentifier: ProfileSettingTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        return tableView
    }()
    
    //MARK: - UI Property UI구성
    let menuList: [String] = [ "프리미엄 이용권", "공지사항", "고객센터 / 도움말", "버전 정보", "차단 관리", "회원 탈퇴"]
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        updateTitleView(title: "설정")
        
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingTableViewCell.identifier, for: indexPath) as? ProfileSettingTableViewCell else { return UITableViewCell() }

        cell.menuLabelText = "    " + menuList[indexPath.row]

        return cell
    }
}
