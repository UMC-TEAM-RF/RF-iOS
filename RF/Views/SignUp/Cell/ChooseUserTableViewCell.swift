//
//  ChooseUserTableViewCell.swift
//  RF
//
//  Created by 정호진 on 2023/08/01.
//

import Foundation
import SnapKit
import UIKit
import RxSwift

final class ChooseUserTableViewCell: UITableViewCell{
    static let identifer = "ChooseUserTableViewCell"
    
    /// MARK: 입력 값
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Functions
    
    private func addSubviews() {
        addSubview(valueLabel)
        
        configureConstraints()
    }
    
    /// MARK: Set AutoLayout
    private func configureConstraints() {
        valueLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
        
    /// 데이터 값 입력
    func inputValue(text: String){
        valueLabel.text = text
    }
}
