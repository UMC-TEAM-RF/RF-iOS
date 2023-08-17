//
//  SearchUniversity.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

final class SearchUniversityViewController: UIViewController{
    
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
        bar.backgroundColor = .clear
        bar.placeholder = UserInfo.bornCountryPlaceHolder
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
    
    /// MARK: 나라 선택하는 tableView
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()
    
    private let viewModel = SearchUniversityViewModel()
    private let disposeBag = DisposeBag()
    var selctedUniversity: PublishSubject<KVO> = PublishSubject()
    
    // MARK: view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        viewModel.inputUniversity()
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
            make.top.equalToSuperview().offset(10)
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

extension SearchUniversityViewController: UISearchBarDelegate{
    
    /// 서치바 변화가 감지 되었을 때
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text?.lowercased() else { return }
        
        viewModel.isFiltering.accept(true)
        viewModel.filteringUniversity(text: text)
        
        tableView.reloadData()
    }
    
    /// 서치바에서 검색버튼을 눌렀을 때 호출
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text?.lowercased() else { return }
        
        viewModel.filteringUniversity(text: text)
        viewModel.isFiltering.accept(false)
        
        tableView.reloadData()
    }
    
    /// 서치바에서 취소 버튼을 눌렀을 때 호출
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        viewModel.isFiltering.accept(false)
        viewModel.inputUniversity()
        
        tableView.reloadData()
    }
    
    /// 서치바 검색이 끝났을 때 호출
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.isFiltering.accept(false)
        viewModel.inputUniversity()
        
        tableView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

extension SearchUniversityViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChooseUserTableViewCell.identifer, for: indexPath) as? ChooseUserTableViewCell else { return UITableViewCell()}
        
        if viewModel.isFiltering.value{
            cell.inputValue(text: viewModel.filteringUniversityRelay.value[indexPath.row].value ?? "")
        }
        else{
            cell.inputValue(text: viewModel.universityRelay.value[indexPath.row].value ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isFiltering.value ? viewModel.filteringUniversityRelay.value.count : viewModel.universityRelay.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.safeAreaLayoutGuide.layoutFrame.height/20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.isFiltering.value ? viewModel.selectedUniversity.accept(viewModel.filteringUniversityRelay.value[indexPath.row]) : viewModel.selectedUniversity.accept(viewModel.universityRelay.value[indexPath.row])
        
        selctedUniversity.onNext(viewModel.selectedUniversity.value)
        dismiss(animated: true)
    }
    
}
