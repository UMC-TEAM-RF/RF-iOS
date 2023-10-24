//
//  MyPageAnnouncementViewController.swift
//  RF
//
//  Created by 용용이 on 2023/10/10.
//

import UIKit

class MyPageAnnouncementViewController: UIViewController {

    //MARK: - UI Property
    
    
    private lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = 60
        return tableView
    }()

    let menuList: [String] = ["서비스 점검 시간 안내", "공지사항", "알프 신고 대상 제한 안내"]
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.backgroundColor = .white
        
        updateTitleView(title: "공지사항")
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
    
    
    private func menuTableViewClicked(at: Int){
        
        switch at {
        case 0:
            self.navigationController?.pushViewController(UIViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(UIViewController(), animated: true)
        case 2:
            self.navigationController?.pushViewController(UIViewController(), animated: true)
        default:
            break
        }
        return
    }

}
// MARK: - Ext: CollectionView

extension MyPageAnnouncementViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.updateTitle(menuList[indexPath.row])

        return cell
    }
    
    //code when the cell is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return }
        
        //Some code
        self.menuTableViewClicked(at: indexPath.item)
    }
}
