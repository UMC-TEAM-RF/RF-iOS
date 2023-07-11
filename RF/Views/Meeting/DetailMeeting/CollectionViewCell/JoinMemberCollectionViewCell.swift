//
//  InterestingCollectioViewCell.swift
//  RF
//
//  Created by 정호진 on 2023/07/11.
//

import Foundation
import UIKit
import SnapKit

final class JoinMemberCollectionViewCell: UICollectionViewCell{
    static let identifier = "JoinMemberCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// MARK: 프로필 사진
    private lazy var profileImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "LogoImage")?.resize(newWidth: 50)
        return img
    }()
    
    /// MARK: 멤버 이름 라벨
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8)
        label.textAlignment = .center
        return label
    }()
    
    /// MARK: 국적 라벨
    private lazy var nationalityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8)
        label.textAlignment = .center
        return label
    }()
    
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
            make.bottom.equalToSuperview().offset(-2)
        }
        
    }
    
    /// inputData
    func inputData(profileImg: String, name: String, nationality: String){
        addUI()
        
        
        nameLabel.text = name
        nationalityLabel.text = nationality
    }
    
}
