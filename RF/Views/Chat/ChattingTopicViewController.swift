//
//  ChattingTopicViewController.swift
//  RF
//
//  Created by 정호진 on 10/13/23.
//

import Foundation
import UIKit
import SnapKit

final class ChattingTopicViewController: UIViewController {
    
    /// MARK: 제목
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "주제"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.backgroundColor = .clear
        return label
    }()
    
    /// MARK: 편집 버튼
    private lazy var editButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("편집", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .clear
        return btn
    }()
    
    /// MARK: tableView
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        return view
    }()
    
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BackgroundColor.gray.color
        
        addSubviews()
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        view.addSubview(titleLabel)
        view.addSubview(editButton)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChattingTopicTableViewCell.self, forCellReuseIdentifier: ChattingTopicTableViewCell.identifier)
        
        constraints()
    }
    
    /// MARK: Set AutoLayout
    private func constraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
        }
        
        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ChattingTopicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Topic.titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChattingTopicTableViewCell.identifier, for: indexPath ) as? ChattingTopicTableViewCell else { return UITableViewCell() }
        cell.inputData(text: Topic.titleList[indexPath.row], imageHidden: false)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chattingTopicDetailViewController = ChattingTopicDetailViewController()
        chattingTopicDetailViewController.selectedTitle = Topic.titleList[indexPath.row]
        
        var list: [String]?
        
        switch indexPath.row {
        case 0:
            list = Topic.music
        case 1:
            list = Topic.sports
        case 2:
            list = Topic.country
        case 3:
            list = Topic.food
        case 4:
            list = Topic.study
        default:
            print("잘못된 접근")
        }
        
        chattingTopicDetailViewController.list = list
        chattingTopicDetailViewController.modalPresentationStyle = .fullScreen
        present(chattingTopicDetailViewController,animated: true)
    }
    
}
