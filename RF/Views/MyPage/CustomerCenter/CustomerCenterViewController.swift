//
//  MyPageCustomerCenterViewController.swift
//  RF
//
//  Created by 용용이 on 2023/10/10.
//

import UIKit

class CustomerCenterViewController: UIViewController {

    //MARK: - UI Property
    
    private lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomerCenterTableViewCell.self, forCellReuseIdentifier: CustomerCenterTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = 60
        return tableView
    }()
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
            self.navigationController?.pushViewController(AnnouncementViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(FAQViewController(), animated: true)
        case 2:
            self.navigationController?.pushViewController(EmailRequestViewController(), animated: true)
        case 3:
            self.navigationController?.pushViewController(MyPageReportViewController(), animated: true)
        default:
            return
        }
    }

}
// MARK: - Ext: CollectionView

extension CustomerCenterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CustomerCenterMenu.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomerCenterTableViewCell.identifier, for: indexPath) as? CustomerCenterTableViewCell else { return UITableViewCell() }

        cell.updateTitle(CustomerCenterMenu.list[indexPath.row]) 

        return cell
    }
    
    //code when the cell is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = tableView.dequeueReusableCell(withIdentifier: CustomerCenterTableViewCell.identifier, for: indexPath) as? CustomerCenterTableViewCell else { return }
        
        //Some code
        self.menuTableViewClicked(at: indexPath.item)
    }
}


