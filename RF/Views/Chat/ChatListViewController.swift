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
    
    let dummyChatList: [Channel] = [
        Channel(id: 1, name: "1번 모임", messages: [
            CustomMessage(content: "TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST", dateTime: "21:09"),
            CustomMessage(sender: CustomMessageSender(speakerId: 1, speakerName: "JD"), content: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
            CustomMessage(sender: CustomMessageSender(speakerId: 1, speakerName: "JD"), content: "t has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
            CustomMessage(sender: CustomMessageSender(speakerId: 2, speakerName: "망고"), content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout"),
            CustomMessage(sender: CustomMessageSender(speakerId: 3, speakerName: "제이디"), content: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..."),
            CustomMessage(sender: CustomMessageSender(speakerId: 4, speakerName: "만자"), content: "Contrary to popular belief, Lorem Ipsum is not simply random text."),
            CustomMessage(sender: CustomMessageSender(speakerId: 2, speakerName: "망고"), content: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
            CustomMessage(sender: CustomMessageSender(speakerId: 2, speakerName: "망고"), content: "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested."),
            CustomMessage(sender: CustomMessageSender(speakerId: 2, speakerName: "망고"), content: "FC BARCELONA EL CLASICO FRENKIE DE JONG PEDRI GAVI SPAIN LA LIGA"),
            CustomMessage(sender: CustomMessageSender(speakerId: 4, speakerName: "만자"), content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
            CustomMessage(sender: CustomMessageSender(speakerId: 3, speakerName: "제이디"), content: "테스트"),
            CustomMessage(sender: CustomMessageSender(speakerId: 3, speakerName: "제이디"), content: "테스트"),
            CustomMessage(sender: CustomMessageSender(speakerId: 4, speakerName: "만자"), content: "테스트"),
            CustomMessage(sender: CustomMessageSender(speakerId: 4, speakerName: "만자"), content: "테스트"),
            CustomMessage(sender: CustomMessageSender(speakerId: 4, speakerName: "만자"), content: "테스트"),
            CustomMessage(sender: CustomMessageSender(speakerId: 2, speakerName: "망고"), content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout")
        ], userProfileImages: ["a", "a"])
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
        cell.inputData(dummy)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatRoomViewController()
        tabBarController?.tabBar.isHidden = true
        vc.messages = self.dummyChatList[indexPath.row].messages
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
