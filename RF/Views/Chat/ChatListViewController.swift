//
//  ChatListViewController.swift
//  RF
//
//  Created by 이정동 on 2023/08/04.
//

import UIKit
import SnapKit

class ChatListViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var chatListTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(ChatListTableViewCell.self, forCellReuseIdentifier: ChatListTableViewCell.identifier)
        tv.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    // MARK: - Property
    
    let dummyChatList: [MeetingList] = [
        MeetingList(imageList: ["a","a","a"], meetingTitle: "모임 1", university: "한국공학대학교", country: "한국", like: true),
        MeetingList(imageList: ["a","a"], meetingTitle: "모임 1", university: "한국공학대학교", country: "한국", like: true),
        MeetingList(imageList: ["a"], meetingTitle: "모임 1", university: "한국공학대학교", country: "한국", like: true),
        MeetingList(imageList: ["a","a","a","a"], meetingTitle: "모임 1", university: "한국공학대학교", country: "한국", like: true)
    ]
    
    // MARK: - viewDidLoad()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        updateTitleView(title: "채팅")
        
        addSubviews()
        configureConstraints()
    }
    
    // MARK: - viewWillAppear()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(chatListTableView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        chatListTableView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
    

}

// MARK: - Ext: TableView

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyChatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.identifier, for: indexPath) as? ChatListTableViewCell else { return UITableViewCell() }
        let dummy = dummyChatList[indexPath.row]
        cell.inputData(imageList: dummy.imageList, meetingName: dummy.meetingTitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatRoomViewController()
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
