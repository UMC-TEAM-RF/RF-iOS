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
        image.image = UIImage(named: "soccer")?.resize(newWidth: 50,newHeight: 50)
        image.clipsToBounds = true
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
        label.text = "aa"
        label.font = .systemFont(ofSize: 14)
        return label
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
        label.text = "aab"
        label.font = .systemFont(ofSize: 14)
        return label
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
        label.text = "aadd"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    /// MARK: 제목 Stack View
    private lazy var titleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [joinedGroupLabel, countryLabel, MBTILabel])
        view.distribution = .fillEqually
        view.axis = .vertical
        return view
    }()
    
    /// MARK: 내용 Stack View
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [joinedGroup, country, MBTI])
        view.distribution = .fillEqually
        view.axis = .vertical
        return view
    }()
    
    /// MARK: 거절 버튼
    private lazy var rejectButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("거절", for: .normal)
        btn.backgroundColor = UIColor(hexCode: "F5F5F5")
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    /// MARK: 수락 버튼
    private lazy var acceptButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("수락", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - addSubviews
    
    private func addSubviews() {
        addSubview(profileImgae)
        addSubview(titleStackView)
        addSubview(stackView)
        
        contentView.addSubview(rejectButton)
        contentView.addSubview(acceptButton)
        configureConstraints()
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        profileImgae.snp.makeConstraints { make in
            make.centerY.equalTo(titleStackView.snp.centerY)
            make.leading.equalToSuperview().offset(20)
        }
        
        titleStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(profileImgae.snp.trailing).offset(20)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(titleStackView.snp.trailing).offset(10)
            
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        rejectButton.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(self.snp.centerX).offset(-10)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        acceptButton.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalTo(self.snp.centerX).offset(10)
            make.bottom.equalToSuperview().offset(-20)
        }

        setOptions()
    }
    
    // MARK: - Actions
    
    /// MARK: setting more options about UI
    private func setOptions(){
        layoutIfNeeded()
        profileImgae.layer.cornerRadius = profileImgae.frame.height/2
    }
}

