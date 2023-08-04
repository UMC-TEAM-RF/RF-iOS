//
//  ProfilesUIView.swift
//  RF
//
//  Created by 정호진 on 2023/07/24.
//

import Foundation
import SnapKit
import UIKit

// MARK: 모임 구성원 프로필 View
final class ProfileUIView: UIView{
    
    /// MARK: first Profile Image
    private lazy var firstProfile: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    /// MARK: second Profile Image
    private lazy var secondProfile: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    /// MARK: third Profile Image
    private lazy var thirdProfile: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    /// MARK: fourth Profile Image
    private lazy var fourthProfile: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - function
    
    /// MARK: add UI
    private func addSubviews(imgList: [String?]){
        
        switch imgList.count{
        case 4..<Int.max:
            addSubview(fourthProfile)
            fallthrough
        case 3..<Int.max:
            addSubview(thirdProfile)
            fallthrough
        case 2..<Int.max:
            addSubview(secondProfile)
            fallthrough
        case 1..<Int.max:
            addSubview(firstProfile)
        default:
            print("ProfileUIView error")
        }
        
        configureConstraints(imgList)
    }
    
    /// MARK: setting AutoLayout
    private func configureConstraints(_ imgList: [String?]){
        
        switch imgList.count{
        case 1:
            firstProfile.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview()
                make.height.equalToSuperview()
                make.width.equalToSuperview()
            }
            
        case 2:
            firstProfile.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.7)
                make.width.equalToSuperview().multipliedBy(0.7)
            }
            secondProfile.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.trailing.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.7)
                make.width.equalToSuperview().multipliedBy(0.7)
            }
        case 3:
            firstProfile.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview()
                make.height.equalToSuperview().dividedBy(2)
                make.width.equalToSuperview().dividedBy(2)
            }
            secondProfile.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.trailing.equalToSuperview()
                make.height.equalToSuperview().dividedBy(2)
                make.width.equalToSuperview().dividedBy(2)
            }
            
            thirdProfile.snp.makeConstraints { make in
                make.top.equalTo(firstProfile.snp.bottom)
                make.centerX.equalToSuperview()
                make.height.equalToSuperview().dividedBy(2)
                make.width.equalToSuperview().dividedBy(2)
            }
            
        case 4:
            firstProfile.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview()
                make.height.equalToSuperview().dividedBy(2)
                make.width.equalToSuperview().dividedBy(2)
            }
            secondProfile.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.trailing.equalToSuperview()
                make.height.equalToSuperview().dividedBy(2)
                make.width.equalToSuperview().dividedBy(2)
            }
            thirdProfile.snp.makeConstraints { make in
                make.top.equalTo(firstProfile.snp.bottom)
                make.leading.equalToSuperview()
                make.height.equalToSuperview().dividedBy(2)
                make.width.equalToSuperview().dividedBy(2)
            }
            fourthProfile.snp.makeConstraints { make in
                make.top.equalTo(secondProfile.snp.bottom)
                make.trailing.equalToSuperview()
                make.height.equalToSuperview().dividedBy(2)
                make.width.equalToSuperview().dividedBy(2)
            }
        default:
            print("ProfileUIView error")
        }
        
    }
    
    /// MARK: 프로필 이미지 넣는 함수
    func inputData(imgList: [String?]){
        addSubviews(imgList: imgList)
        
        switch imgList.count{
        case 4..<Int.max:
            fourthProfile.image = UIImage(named: "LogoImage")
            fourthProfile.layer.cornerRadius = 30
            fallthrough
        case 3..<Int.max:
            thirdProfile.image = UIImage(named: "LogoImage")
            thirdProfile.layer.cornerRadius = 30
            fallthrough
        case 2..<Int.max:
            secondProfile.image = UIImage(named: "LogoImage")
            secondProfile.layer.cornerRadius = 30
            fallthrough
        case 1..<Int.max:
            firstProfile.image = UIImage(named: "LogoImage")
            firstProfile.layer.cornerRadius = 30
        default:
            print("ProfileUIView error")
        }
        
    }
    
}
