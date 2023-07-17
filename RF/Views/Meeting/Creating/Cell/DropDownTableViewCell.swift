//
//  DropDownTableViewCell.swift
//  RF
//
//  Created by 이정동 on 2023/07/16.
//

import UIKit
import SnapKit

class DropDownTableViewCell: UITableViewCell {
    
    static let identifier = "DropDownTableViewCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubviews() {
        contentView.addSubview(label)
    }
    
    private func configureConstraints() {
        label.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }

}
