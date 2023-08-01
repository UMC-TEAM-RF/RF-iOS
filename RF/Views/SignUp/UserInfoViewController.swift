//
//  UserInfoViewController.swift
//  RF
//
//  Created by 나예은 on 2023/07/10.
//07-1

import UIKit
import SnapKit

class UserInfoViewController: UIViewController {
    
    // MARK: - 기본정보
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "알프님의\n기본 정보를 설정해주세요!"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - 출생국가
    private lazy var userNationLabel: UILabel = {
        let label = UILabel()
        label.text = "출생 국가"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    private lazy var nationButton: UIButton = {
        let button = UIButton()
        button.setTitle("  " + "국가를 선택해주세요", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor =  UIColor(hexCode: "#F5F5F5")
        button.layer.cornerRadius = 5
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let tableView = UITableView()
    private let data = ["항목 1", "항목 2", "항목 3", "항목 4", "항목 5"]

    private lazy var tableViewHeightConstraint: NSLayoutConstraint = {
            let constraint = tableView.heightAnchor.constraint(equalToConstant: 0)
            constraint.priority = .defaultLow
            return constraint
        }()

    
    
    private lazy var favNationLabel: UILabel = {
        let label = UILabel()
        label.text = "관심 나라"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    private lazy var favNationButton: UIButton = {
        let button = UIButton()
        button.setTitle("  관심있는 나라를 선택해주세요", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor =  UIColor(hexCode: "#F5F5F5")
        button.layer.cornerRadius = 5
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    
    private lazy var favLanguageLabel: UILabel = {
        let label = UILabel()
        label.text = "관심 언어"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    private lazy var favLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle("  관심있는 언어를 선택해주세요", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor =  UIColor(hexCode: "#F5F5F5")
        button.layer.cornerRadius = 5
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.backgroundColor =  UIColor(hexCode: "#F5F5F5")
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 다음 버튼 액션
    @objc private func nextButtonTapped() {
        let userinfoSelfViewController = UserInfoSelfViewController()
        navigationController?.pushViewController(userinfoSelfViewController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        configureConstraints()
        setupTableView()
        setupNationButton()
        
    }
    
    private func setupTableView() {
            view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.isHidden = true
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }

    private func setupNationButton() {
            nationButton.addTarget(self, action: #selector(showNationMenu), for: .touchUpInside)
        }

    @objc private func showNationMenu() {
        tableView.reloadData()
        
        tableViewHeightConstraint.constant = view.frame.height / 3
        tableView.isHidden = false // 테이블 뷰를 숨기지 않고 보여줌

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func addSubviews() {
        view.addSubview(topLabel)
        view.addSubview(userNationLabel)
        view.addSubview(favNationLabel)
        view.addSubview(favLanguageLabel)
        view.addSubview(nextButton)
        view.addSubview(nationButton)
        view.addSubview(favNationButton)
        view.addSubview(favLanguageButton)
    }
    
    private func configureConstraints() {
        
        //알프닝의 기본 정보를 설정해주세요.
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        //출생 국가
        userNationLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        //국가 설정 메뉴 버튼
        nationButton.snp.makeConstraints { make in
            make.top.equalTo(userNationLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(47)
        }
        
        //관심 나라
        favNationLabel.snp.makeConstraints { make in
            make.top.equalTo(nationButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        //관심 나라 설정 메뉴 버튼
        favNationButton.snp.makeConstraints { make in
            make.top.equalTo(favNationLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(47)
        }
        
        //관심 언어
        favLanguageLabel.snp.makeConstraints { make in
            make.top.equalTo(favNationButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        //관심 언어 설정 메뉴 버튼
        favLanguageButton.snp.makeConstraints { make in
            make.top.equalTo(favLanguageLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(47)
        }
        
        //다음
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(655)
            make.leading.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(50)
            }
        }

    }

extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = data[indexPath.row]
        print("선택된 항목: \(selectedItem)")
        nationButton.setTitle("  " + selectedItem, for: .normal)
                hideNationMenu()
    }
    private func hideNationMenu() {
            UIView.animate(withDuration: 0.3) {
                self.tableViewHeightConstraint.constant = 0
                self.tableView.isHidden = true
                self.view.layoutIfNeeded()
            }
        }
}
