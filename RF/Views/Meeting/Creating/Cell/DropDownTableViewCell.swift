//
//  DropDownTableViewCell.swift
//  RF
//
//  Created by 이정동 on 2023/07/16.
//

import UIKit
import SnapKit

class DropDownTableViewCell: UITableViewCell {
    
    // MARK: - UI Property
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    // MARK: - Property
    
    static let identifier = "DropDownTableViewCell"
    
    // MARK: - init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        contentView.addSubview(label)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        label.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }

}
