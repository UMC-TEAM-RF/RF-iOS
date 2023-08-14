//
//  ProfileSettingTableViewCell.swift
//  RF
//
//  Created by 나예은 on 2023/08/12.
//

import UIKit
import SnapKit

class ProfileSettingTableViewCell: UITableViewCell {
    
    //MARK: - UI Property
    private lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var menubutton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let btimage = UIImage(systemName: "chevron.right", withConfiguration: imageConfig)?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        button.setImage(btimage, for: .normal)
        
        button.addTarget(self, action: #selector(menubuttonTapped(_:)), for: .touchUpInside)
        
        return button
    }()

    @objc private func menubuttonTapped(_ sender: UIButton) {
        print("Arrow button tapped ")
        // 버튼을 눌렀을 때 
    }


    // MARK: - Property
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

    // MARK: - addSubviews()
    private func addSubviews() {
        contentView.addSubview(menuLabel)
        contentView.addSubview(menubutton)
    }
    
    // MARK: - configureConstraints() 
    private func configureConstraints() {
        menuLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
        }
        
        menubutton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-40)
        }

        }
}
