//
//  NotiAcceptRejectViewController.swift
//  RF
//
//  Created by 정호진 on 2023/08/11.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
import SnapKit

final class GroupJoinRequestViewController: UIViewController {
    
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: " ", style: .done, target: self, action: nil)
        btn.isEnabled = false
        btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .disabled)
        return btn
    }()
    
    /// MARK: 알림 라벨
    private lazy var noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "24시간 이내에 수락 혹은 거절 버튼을 눌러주세요!"
        return label
    }()
    
    /// MARK: 해당 모임에 신청한 사람들 리스트
    private lazy var listTableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    var titleRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    private let viewModel = NotiAcceptRejectViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = .black
        
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        addSubviews()
        bind()
    }
    
    
    // MARK: - addSubviews
    
    private func addSubviews() {
        view.addSubview(noticeLabel)
        view.addSubview(listTableView)
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(GroupJoinRequestTableViewCell.self, forCellReuseIdentifier: GroupJoinRequestTableViewCell.identifier)
        
        configureConstraints()
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        noticeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(noticeLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - bind
    
    /// MARK: binding viewModel
    private func bind() {
        titleRelay.bind { [weak self] title in
            self?.leftButton.title = title
        }
        .disposed(by: disposeBag)
    }
    
    /// MARK: 수락 버튼 누른 경우
    private func clickedAcceptButton(indexPath: IndexPath){
        print("clickedAcceptButton\n\(indexPath)")
        
    }
    
    /// MARK: 거절 버튼 누른 경우
    private func clickedRejectButton(indexPath: IndexPath){
        print("clickedRejectButton\n\(indexPath)")
    }
    
    
}

extension GroupJoinRequestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notificationAcceptRejectList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupJoinRequestTableViewCell.identifier, for: indexPath) as? GroupJoinRequestTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.delegate = self
        cell.indexPath.accept(indexPath)
        
        let data = viewModel.notificationAcceptRejectList.value
        cell.inputData(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.safeAreaLayoutGuide.layoutFrame.height/4
    }
    
}

extension GroupJoinRequestViewController: GroupJoinRequestDelegate {
    
    /// 거절 버튼을 눌렀을 때
    func clickedReject(_ indexPath: IndexPath) {
        clickedRejectButton(indexPath: indexPath)
    }
    
    /// 수락 버튼을 눌렀을 때
    func clickedAccept(_ indexPath: IndexPath) {
        clickedAcceptButton(indexPath: indexPath)
    }
    
    
}
