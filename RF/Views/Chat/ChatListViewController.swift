//
//  ChatListViewController.swift
//  RF
//
//  Created by 이정동 on 2023/08/04.
//

import UIKit
import SnapKit
import RealmSwift

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
    
    private var channels: Results<RealmChannel>!
    
    // MARK: - viewDidLoad()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        updateTitleView(title: "채팅")
        
        addSubviews()
        configureConstraints()
        getChannelList()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateChat), name: NotificationName.updateChatList, object: nil)
    }
    
    // MARK: - viewWillAppear()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        isLocatedCurrentView = true
        
        if isUpdateChannel { // 채팅방 업데이트 된 상태인 경우
            getChannelList()
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
    
    private func getChannelList() {
        channels = ChatRepository.shared.getAllChannel()
        chatListTableView.reloadData()
    }
    
    // MARK: - @objc func
    
    // NotificationCenter에 등록된 함수
    @objc func updateChat() {
        if isLocatedCurrentView { // 현재 뷰에 위치할 경우
            // 즉시 채팅방 리스트 업데이트
            getChannelList()
        } else { // 다른 뷰에 위치해 있는 경우
            // 업데이트 상태 저장 후 뷰 나타날 시 업데이트
            isUpdateChannel = true
        }
    }
}

// MARK: - Ext: TableView

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.identifier, for: indexPath) as? ChatListTableViewCell else { return UITableViewCell() }
        
        cell.updateChannelView(channels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatRoomViewController()
        
        vc.channel = channels[indexPath.row]
        vc.row = ChatRepository.shared.readNewMessages(channels[indexPath.row].id)
        
        // 메시지 읽음 처리 후 테이블 뷰 리로드 필요
        
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
