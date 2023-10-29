//
//  MyPageBlockUserListViewController.swift
//  RF
//
//  Created by 용용이 on 2023/10/10.
//

import UIKit

class MyPageBlockUserListViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var userListTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(MyPageBlockUserListViewCell.self, forCellReuseIdentifier: MyPageBlockUserListViewCell.identifier)
        tv.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    // MARK: - Property
    private var isUpdateUser: Bool = false
    private var isLocatedCurrentView: Bool = false
    
    
    // MARK: - Dummy Data
    
    private var banList = [User(loginId: "kimhim", password: nil, university: "디자인융합학과", nickname: "김성연", email: nil, lifeStyle: nil, entrance: 19, country: "대한민국", introduce: nil, interestLanguage: nil, interestCountry: nil, interest: nil, mbti: nil, profileImageUrl: "https://rf-aws-bucket.s3.ap-northeast-2.amazonaws.com/userDefault/defaultImage.jpg", userId: 50)]
    
    
    // MARK: - viewDidLoad()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        updateTitleView(title: "차단 관리")
        setupCustomBackButton()
        
        addSubviews()
        configureConstraints()
        
        updateUser()
    }
    
    // MARK: - viewWillAppear()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        isLocatedCurrentView = true
        
        if isUpdateUser {
            updateUserList()
            isUpdateUser = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        isLocatedCurrentView = false
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(userListTableView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        userListTableView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func updateUserList() {
        //Data fetch code will be inserted
        self.userListTableView.reloadData()
    }
    
    // MARK: - @objc func
    
    @objc func updateUser() {
        if isLocatedCurrentView {
            updateUserList()
        } else {
            isUpdateUser = true
        }
    }
}

// MARK: - Ext: TableView

extension MyPageBlockUserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageBlockUserListViewCell.identifier, for: indexPath) as? MyPageBlockUserListViewCell else { return UITableViewCell() }
        cell.updateUserView(banList[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
