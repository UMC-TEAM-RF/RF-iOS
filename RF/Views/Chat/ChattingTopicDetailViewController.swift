//
//  ChattingTopicViewController.swift
//  RF
//
//  Created by 정호진 on 10/13/23.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ChattingTopicDetailViewController: UIViewController {
    
    /// MARK: 제목
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = selectedTitle
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.backgroundColor = .clear
        return label
    }()
    
    /// MARK: 종료 버튼
    private lazy var closeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        btn.backgroundColor = .clear
        return btn
    }()
    
    /// MARK: tableView
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        return view
    }()
    
    var selectedTitle: String?
    var list: [String]?
    private let disposeBag = DisposeBag()
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BackgroundColor.gray.color
        
        addSubviews()
        bind()
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
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
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.leading.equalToSuperview().offset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    /// MARK: bind
    private func bind(){
        closeButton.rx.tap
            .bind { [weak self] _ in
                guard let self = self else {return}
                dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}

extension ChattingTopicDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChattingTopicTableViewCell.identifier, for: indexPath ) as? ChattingTopicTableViewCell else { return UITableViewCell() }
        cell.inputData(text: list?[indexPath.row] ?? "", imageHidden: true)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
}

