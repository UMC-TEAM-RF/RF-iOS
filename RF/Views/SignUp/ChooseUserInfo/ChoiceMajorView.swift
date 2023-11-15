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

final class ChoiceMajorView: UIViewController{
    
    /// MARK: 제목
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = UserInfo.major
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    /// MARK: 검색 바
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.backgroundColor = .clear
        bar.placeholder = UserInfo.majorPlaceHolder
        bar.searchBarStyle = .minimal
        bar.showsCancelButton = true
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "취소 "
        return bar
    }()
    
    /// MARK: 위쪽 백그라운드
    private lazy var topBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    /// MARK: 학과 선택하는 tableView
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()
    
    private let viewModel = ChoiceMajorViewModel()
    private let disposeBag = DisposeBag()
    var selctedMajor: PublishSubject<KVO> = PublishSubject()
    
    // MARK: view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        viewModel.inputCountry()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Functions
    
    private func addSubviews() {
        view.addSubview(topBackgroundView)
        
        topBackgroundView.addSubview(titleLabel)
        topBackgroundView.addSubview(searchBar)
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
            make.bottom.equalToSuperview()
        }
        
        topBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/8)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension ChoiceMajorView: UISearchBarDelegate{
    
    /// 서치바 변화가 감지 되었을 때
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text?.lowercased() else { return }
        
        viewModel.isFiltering.accept(true)
        viewModel.filteringCountry(text: text)
        
        tableView.reloadData()
    }
    
    /// 서치바에서 검색버튼을 눌렀을 때 호출
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text?.lowercased() else { return }
        
        viewModel.filteringCountry(text: text)
        viewModel.isFiltering.accept(false)
        
        tableView.reloadData()
    }
    
    /// 서치바에서 취소 버튼을 눌렀을 때 호출
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        viewModel.isFiltering.accept(false)
        viewModel.inputCountry()
        
        tableView.reloadData()
    }
    
    /// 서치바 검색이 끝났을 때 호출
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.isFiltering.accept(false)
        viewModel.inputCountry()
        
        tableView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

extension ChoiceMajorView: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChooseUserTableViewCell.identifer, for: indexPath) as? ChooseUserTableViewCell else { return UITableViewCell() }
        
        if viewModel.isFiltering.value{
            cell.inputValue(text: viewModel.filteringCountryRelay.value[indexPath.row].value ?? "")
        }
        else{
            cell.inputValue(text: viewModel.majorRelay.value[indexPath.row].value ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isFiltering.value ? viewModel.filteringCountryRelay.value.count : viewModel.majorRelay.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.safeAreaLayoutGuide.layoutFrame.height/20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.isFiltering.value ? viewModel.selectedCountry.accept(viewModel.filteringCountryRelay.value[indexPath.row]) : viewModel.selectedCountry.accept(viewModel.majorRelay.value[indexPath.row])
        
        selctedMajor.onNext(viewModel.selectedCountry.value)
        dismiss(animated: true)
    }
    
}
