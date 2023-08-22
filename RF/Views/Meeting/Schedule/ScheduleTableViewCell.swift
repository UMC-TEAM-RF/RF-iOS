//
//  ScheduleTableViewCell.swift
//  RF
//
//  Created by 정호진 on 2023/07/21.
//

import UIKit
import SnapKit

final class ScheduleTableViewCell: UITableViewCell {
    static let identifier = "ScheduleTableViewCell"
    
    /// MARK: 일정을 표시할 라벨
    private lazy var eventLabel: UILabel = {
        let label = UILabel()
        label.textColor = TextColor.first.color
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    /// MARK: 라벨 둘러싸는 View
    private lazy var aroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        addSubview(aroundView)
        aroundView.addSubview(eventLabel)
        
        configureConstraints()
    }
    
    /// MARK: Setting AutoLayout
    private func configureConstraints(){
        aroundView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalToSuperview().offset(-2)
            make.top.equalToSuperview().offset(2)
            make.bottom.equalToSuperview().offset(-2)
        }
        
        eventLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(3)
            make.trailing.equalToSuperview().offset(-3)
        }
        
    }

    /// MARK: 일정을 넣는 함수
    func inputData(text: String?, backgroundColor: UIColor?){
        guard let text = text, let backgroundColor = backgroundColor else { return }
        eventLabel.text = text
        aroundView.backgroundColor = backgroundColor
    }
    
}
