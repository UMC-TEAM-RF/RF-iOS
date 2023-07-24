//
//  ListTableViewCell.swift
//  RF
//
//  Created by 정호진 on 2023/07/24.
//

import Foundation
import UIKit
import SnapKit

final class ListTableViewCell: UITableViewCell{
    static let identifier = "ListTableViewCell"
    
    /// MARK: 프로필 들어갈 View
    private lazy var profileUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    /// MARK: 모임 이름
    private lazy var meetingTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    /// MARK: 소속된 학교 이름
    private lazy var universityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    /// MARK: 소속된 국가 아이콘
    private lazy var countryLabel: UILabel = {
        let label = UILabel()

        return label
    }()
    
    /// MARK: 찜하기 버튼
    private lazy var likeButton: UIButton = {
        let btn = UIButton()
        
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// MARK: add UI
    private func addSubviews(){
        addSubview(profileUIView)
        addSubview(meetingTitleLabel)
        addSubview(universityLabel)
        addSubview(countryLabel)
        contentView.addSubview(likeButton)
        
        configureConstraints()
    }
    
    /// MARK: setting AutoLayout
    private func configureConstraints(){
        profileUIView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        
        
    }
    
    
}
