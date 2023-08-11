//
//  NotiAcceptRejectTableViewCell.swift
//  RF
//
//  Created by 정호진 on 2023/08/11.
//

import Foundation
import UIKit
import SnapKit

final class NotiAcceptRejectTableViewCell: UITableViewCell {
    static let identifier = "NotiAcceptRejectTableViewCell"
    
    /// MARK: 사용자 프로필 이미지
    private lazy var profileImgae: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    /// MARK: 소속 라벨
    private lazy var joinedGroupLabel: UILabel = {
        let label = UILabel()
        label.text = "소속"
        label.font = .systemFont(ofSize: 14,weight: .semibold)
        return label
    }()
    
    /// MARK: 소속
    private lazy var joinedGroup: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    /// MARK: 소속 묶는 view
    private lazy var joinedGroupView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    /// MARK: 국가 라벨
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = "국가"
        label.font = .systemFont(ofSize: 14,weight: .semibold)
        return label
    }()
    
    /// MARK: 국가 라벨
    private lazy var country: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    /// MARK: 국가 묶는 view
    private lazy var countryView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    /// MARK: MBTI 라벨
    private lazy var MBTILabel: UILabel = {
        let label = UILabel()
        label.text = "MBTI"
        label.font = .systemFont(ofSize: 14,weight: .semibold)
        return label
    }()
    
    /// MARK: MBTI 라벨
    private lazy var MBTI: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    /// MARK: MBTI 묶는 view
    private lazy var MBTIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    /// MARK: 거절 버튼
    private lazy var rejectButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("거절", for: .normal)
        btn.backgroundColor = UIColor(hexCode: "F5F5F5")
        return btn
    }()
    
    /// MARK: 수락 버튼
    private lazy var acceptButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("수락", for: .normal)
        btn.backgroundColor = UIColor(hexCode: "F5F5F5")
        return btn
    }()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - addSubviews
    
    private func addSubviews() {
        addSubview(profileImgae)
        addSubview(joinedGroupView)
        joinedGroupView.addSubview(joinedGroupLabel)
        joinedGroupView.addSubview(joinedGroup)
        
        addSubview(countryView)
        countryView.addSubview(countryLabel)
        countryView.addSubview(country)
        
        addSubview(MBTIView)
        MBTIView.addSubview(MBTILabel)
        MBTIView.addSubview(MBTI)
        
        contentView.addSubview(rejectButton)
        contentView.addSubview(acceptButton)
        configureConstraints()
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        
    }
}
