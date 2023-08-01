//
//  ChoiceCountryTableView.swift
//  RF
//
//  Created by 정호진 on 2023/08/01.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

final class ChoiceBornCountryView: UIViewController{
    
    /// MARK: 제목
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = UserInfo.bornCountry
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    /// MARK: 검색 바
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        
        return bar
    }()
    
    /// MARK: 나라 선택하는 tableView
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()
    
    private let viewModel = ChoiceBornCountryViewModel()
    
    // MARK: view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        viewModel.inputCountry()
    }
    
    // MARK: - Functions
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        searchBar.delegate = self
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChooseUserTableViewCell.self, forCellReuseIdentifier: ChooseUserTableViewCell.identifer)
        
        configureConstraints()
    }
    
    /// MARK: Set AutoLayout
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension ChoiceBornCountryView: UISearchBarDelegate{
    
}

extension ChoiceBornCountryView: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChooseUserTableViewCell.identifer, for: indexPath) as? ChooseUserTableViewCell else { return UITableViewCell()}
        cell.inputValue(text: viewModel.countryRelay.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return viewModel.countryRelay.value.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.safeAreaLayoutGuide.layoutFrame.height/20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
