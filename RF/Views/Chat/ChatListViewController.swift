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
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateChat), name: NotificationName.updateChatList, object: nil)
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
        //SingletonChannel.shared.sortByLatest()
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
//        return SingletonChannel.shared.list.count
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.identifier, for: indexPath) as? ChatListTableViewCell else { return UITableViewCell() }
//        let channel = SingletonChannel.shared.list[indexPath.row]
//        cell.updateChannelView(channel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatRoomViewController()
        
//        let channel = SingletonChannel.shared.list[indexPath.row]
//        
//        let index = SingletonChannel.shared.readNewMessage(channel.id)
//        
//        vc.channel = channel
//        vc.row = index
        
        tableView.reloadData()
        
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 오른쪽에 만들기
        
        let alert = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("알림 여부 클릭")
            success(true)
        }
        alert.backgroundColor = .lightGray
        alert.image = UIImage(systemName: "bell.fill")
        
        let exit = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("나가기 클릭")
            success(true)
        }
        exit.backgroundColor = .systemRed
        exit.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        
        //actions배열 인덱스 0이 오른쪽에 붙어서 나옴
        let configure = UISwipeActionsConfiguration(actions: [exit, alert])
        configure.performsFirstActionWithFullSwipe = false
        
        return configure
    }
    
    
}
