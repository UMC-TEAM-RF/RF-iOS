//
//  MyPageCustomerCenterViewController.swift
//  RF
//
//  Created by 용용이 on 2023/10/10.
//

import UIKit

class MyPageCustomerCenterViewController: UIViewController {

    //MARK: - UI Property
    
    
    private lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(settingTableViewCell.self, forCellReuseIdentifier: settingTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = 60
        return tableView
    }()

    let menuList: [String] = ["자주 묻는 질문", "이메일 문의", "알프 신고하기"]
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.backgroundColor = .white
        
        updateTitleView(title: "고객센터")
        setupCustomBackButton()
        
        addSubviews()
        configureConstraints()
    }
    
    // MARK: - addsubviews()
    private func addSubviews() {
        view.addSubview(menuTableView)
    }

    // MARK: - configureConstraints()
    private func configureConstraints() {
        menuTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    private func menuTableViewClicked(at: Int){
        
        switch at {
        case 0:
            self.navigationController?.pushViewController(MyPageFAQViewController(), animated: true)
            return
        case 1:
            self.navigationController?.pushViewController(MyPageEmailRequestViewController(), animated: true)
            return
        case 2:
            self.navigationController?.pushViewController(MyPageReportViewController(), animated: true)
            return
        default:
            return
        }
    }

}
// MARK: - Ext: CollectionView

extension MyPageCustomerCenterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: settingTableViewCell.identifier, for: indexPath) as? settingTableViewCell else { return UITableViewCell() }

        cell.updateTitle(menuList[indexPath.row]) 

        return cell
    }
    
    //code when the cell is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = tableView.dequeueReusableCell(withIdentifier: settingTableViewCell.identifier, for: indexPath) as? settingTableViewCell else { return }
        
        //Some code
        self.menuTableViewClicked(at: indexPath.item)
//
//
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(descriptLabel)
//        contentView.addSubview(rightButton)
    }
}

// MARK: - MyPageFAQViewController
class MyPageFAQViewController: UIViewController {
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        updateTitleView(title: "자주 묻는 질문")
        setupCustomBackButton()
        
        addSubviews()
        configureConstraints()
    }
    
    /// MARK: - addsubviews()
    private func addSubviews() {
//        view.addSubview(menuTableView)
    }

    /// MARK: - configureConstraints()
    private func configureConstraints() {
//        menuTableView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.horizontalEdges.equalToSuperview()
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
    }
}


// MARK: - MyPageEmailRequestViewController
class MyPageEmailRequestViewController: UIViewController {
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        updateTitleView(title: "이메일 문의")
        setupCustomBackButton()
        
        addSubviews()
        configureConstraints()
    }
    
    /// MARK: - addsubviews()
    private func addSubviews() {
//        view.addSubview(menuTableView)
    }

    /// MARK: - configureConstraints()
    private func configureConstraints() {
//        menuTableView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.horizontalEdges.equalToSuperview()
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
    }
}
