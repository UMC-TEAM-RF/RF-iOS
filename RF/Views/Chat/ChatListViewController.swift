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
    private var isUpdateChannel: Bool = false
    private var isLocatedCurrentView: Bool = false
    
    // MARK: - viewDidLoad()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        updateTitleView(title: "채팅")
        
        addSubviews()
        configureConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateChat), name: NotificationName.updateChat, object: nil)
    }
    
    // MARK: - viewWillAppear()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        isLocatedCurrentView = true
        
        if isUpdateChannel {
            updateChannelList()
            isUpdateChannel = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        isLocatedCurrentView = false
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
    
    private func updateChannelList() {
        SingletonChannel.shared.sortByLatest()
        self.chatListTableView.reloadData()
    }
    
    // MARK: - @objc func
    
    @objc func updateChat() {
        if isLocatedCurrentView {
            updateChannelList()
        } else {
            isUpdateChannel = true
        }
    }
}

// MARK: - Ext: TableView

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SingletonChannel.shared.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.identifier, for: indexPath) as? ChatListTableViewCell else { return UITableViewCell() }
        let channel = SingletonChannel.shared.list[indexPath.row]
        cell.updateChannelView(channel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatRoomViewController()
        tabBarController?.tabBar.isHidden = true
        
        let channel = SingletonChannel.shared.list[indexPath.row]
        vc.channelId = channel.id
        vc.messages = channel.messages
        
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
