//
//  ProfileSettingTableViewCell.swift
//  RF
//
//  Created by 나예은 on 2023/08/12.
//

import UIKit
import SnapKit

class ProfileSettingTableViewCell: UITableViewCell {
    
    //MARK: - UI Property UI구성
    private lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var menubutton: UIButton = {
        let button = UIButton()
        let btimage = UIImage(systemName: "chevron.right.to.line")
        button.setImage(btimage, for: .normal)
        return button
    }()

    
    // MARK: - Property 테이블 뷰 입력
    static let identifier = "ProfileSettingTableViewCell"
    
    var menuLabelText: String? {
        didSet {
            self.menuLabel.text = menuLabelText
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureConstraints()
        selectionStyle = .none
        
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - addSubviews() 뷰 나타내기
    private func addSubviews() {
        contentView.addSubview(menuLabel)
        contentView.addSubview(menubutton)
    }
    
    // MARK: - configureConstraints() 뷰 제약걸기
    private func configureConstraints() {
        menuLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
        }
        
        menubutton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }

        }
}
