//
//  DropDownButton.swift
//  RF
//
//  Created by 이정동 on 2023/07/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DropDownButton: UIView {
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 0
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    private lazy var dropDownButton: UIButton = {
        var configure = UIButton.Configuration.plain()
        configure.imagePadding = 10
        
        let button = UIButton(configuration: configure)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .gray
        button.setTitleColor(.blue, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    private lazy var dropDownTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(DropDownTableViewCell.self, forCellReuseIdentifier: DropDownTableViewCell.identifier)
        tv.isHidden = true
        tv.layer.borderWidth = 1.2
        tv.layer.borderColor = UIColor.gray.cgColor
        tv.rowHeight = 40
        return tv
    }()
    
    private let disposeBag = DisposeBag()
    
    weak var delegate: DropDownButtonDelegate?
    
    var title: String? {
        didSet {
            self.dropDownButton.setTitle(title, for: .normal)
        }
    }
    
    var dataSources: [Int] = [1, 2, 3, 4, 5, 6, 7, 8] {
        didSet {
            self.updateTableDataSource()
        }
    }
    
    // 테이블 뷰 높이 참조 제약 사항
    var tableViewHeightConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(dropDownButton)
        stackView.addArrangedSubview(dropDownTableView)
    }
    
    private func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dropDownButton.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        dropDownTableView.snp.makeConstraints { make in
            make.top.equalTo(dropDownButton.snp.bottom)
            //make.horizontalEdges.bottom.equalToSuperview() // Animation 적용할 때 필요할 듯
            tableViewHeightConstraint = make.height.equalTo(0).constraint
        }
    }
    
    private func addTargets() {
        dropDownButton.rx.tap
            .subscribe(onNext: {
                self.delegate?.buttonTapped(self)
                UIView.transition(with: self.dropDownTableView, duration: 0.3, options: .transitionCrossDissolve) {
                    self.dropDownTableView.isHidden.toggle()
                }
            })
            .disposed(by: disposeBag)
    }
    
    // DataSource 개수에 따른 테이블 뷰 높이 수정
    private func updateTableDataSource() {
        if dataSources.count >= 4 {
            tableViewHeightConstraint?.update(offset: 40 * 4)
        } else {
            tableViewHeightConstraint?.update(offset: dataSources.count * 40)
        }
        dropDownTableView.reloadData()
    }
    
    func hideTableView() {
        self.dropDownTableView.isHidden = true
    }
}

extension DropDownButton: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.identifier, for: indexPath) as! DropDownTableViewCell
        cell.label.text = "\(dataSources[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap")
        self.delegate?.itemSelected("\(dataSources[indexPath.row])")
        self.hideTableView()
    }
}
