
//  ProfileSettingViewController
//  ProfileSettingViewController.swift
//  RF
//
//  Created by 이정동 on 2023/08/01.
//

import UIKit
import SnapKit

class ProfileSettingViewController: UIViewController {

    var tableView: UITableView!
    let data = ["프리미엄 이용권", "공지사항", "고객센터 / 도움말", "버전 정보", "차단 관리", "회원 탈퇴"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupSomeView() // someView 먼저 배치
        setupTableView() // 그 다음 테이블 뷰 배치
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80) // someView 아래로 배치
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupSomeView() {
        let someView = UIView()
        someView.backgroundColor = .white // 배경색 설정
        
        let label = UILabel()
        label.text = "설정"
        label.textColor = .black
        
        let button = UIButton(type: .system)
        button.setTitle("Click Me", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(someView)
        someView.addSubview(label)
        someView.addSubview(button)
        
        someView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(70) // 뷰 높이 조정
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func buttonTapped() {
        // 버튼 클릭 시 동작할 내용 추가
    }
}

extension ProfileSettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.backgroundColor = .clear
        
        // Add arrow button to each cell
        let arrowButton = UIButton(type: .custom)
        arrowButton.setImage(UIImage(named: "carat.png"), for: .normal)
        arrowButton.tag = indexPath.row
        arrowButton.addTarget(self, action: #selector(arrowButtonTapped(_:)), for: .touchUpInside)
        
        cell.accessoryView = arrowButton
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65 // 각 셀의 높이 조정
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc private func arrowButtonTapped(_ sender: UIButton) {
        let rowIndex = sender.tag
        print("Arrow button tapped for row \(rowIndex)")
        // Handle the arrow button tap action for the specific row
    }
}
