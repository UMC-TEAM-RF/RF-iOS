//
//  InterestingCollectioViewCell.swift
//  RF
//
//  Created by 정호진 on 2023/07/11.
//

import Foundation
import UIKit
import SnapKit

final class JoinMemberCollectionViewCell: UICollectionViewCell {
    
    /// MARK: 프로필 사진
    private lazy var profileImg: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 20
        img.clipsToBounds = true
        return img
    }()
    
    /// MARK: 멤버 이름 라벨
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 국적 라벨
    private lazy var nationalityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = TextColor.first.color
        return label
    }()
    
    static let identifier = "JoinMemberCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// Add UI
    private func addUI(){
        addSubview(profileImg)
        addSubview(nameLabel)
        addSubview(nationalityLabel)
        
        profileImg.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImg.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        nationalityLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
//            make.bottom.equalToSuperview().offset(-2)
        }
        
    }
    
    /// inputData
    func inputData(profileImg: String, name: String, nationality: String){
        addUI()
        
        self.profileImg.image = UIImage(named: "LogoImage")?.resize(newWidth: 50, newHeight: 50)
        nameLabel.text = name
        nationalityLabel.text = nationality
    }
    
}
