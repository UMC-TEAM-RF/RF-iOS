//
//  GroupProfileView.swift
//  RF
//
//  Created by 이정동 on 2023/08/09.
//

import UIKit

final class GroupProfileView: UIView {
    
    // 이미지 뷰 배열
    private var imageViews: [UIImageView] = []
    private let avatarSpacing: CGFloat = 0.7
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImageViews()
    }
    
    private func setupImageViews() {
        // 최대 4개의 이미지 뷰 생성 및 배열에 추가
        for _ in 0 ..< 4 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 5 // 원하는 코너 반경 설정
            imageViews.append(imageView)
            addSubview(imageView)
        }
    }
    
    func updateProfileImages(with profiles: [String]) {
        // 인원 수에 맞게 이미지 뷰 숨기기/보이기
        for (index, imageView) in imageViews.enumerated() {
            if index < profiles.count {
                if let url = URL(string: profiles[index]){
                    imageView.load(url: url)
                }
                else{
                    imageView.image = UIImage(named: "LogoImage")
                }
                imageView.isHidden = false
            } else {
                imageView.isHidden = true
            }
        }
        
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let visibleImageViews = imageViews.filter { !$0.isHidden }
        let imageSize: CGFloat
        
        switch visibleImageViews.count {
        case 1: imageSize = bounds.width
        case 2: imageSize = bounds.width * avatarSpacing
        default: imageSize = bounds.width / 2
        }
        
        for (index, imageView) in visibleImageViews.enumerated() {
            switch visibleImageViews.count {
            case 1:
                imageView.frame = CGRect(x: 0, y: 0, width: imageSize, height: imageSize)
            case 2:
                if index == 0 {
                    imageView.frame = CGRect(x: 0, y: 0, width: imageSize, height: imageSize)
                } else {
                    imageView.frame = CGRect(x: bounds.width - imageSize, y: bounds.height - imageSize, width: imageSize, height: imageSize)
                }
            case 3:
                switch index {
                case 0:
                    imageView.frame = CGRect(x: (bounds.width - imageSize) / 2, y: 0, width: imageSize, height: imageSize)
                case 1:
                    imageView.frame = CGRect(x: 0, y: bounds.height - imageSize, width: imageSize, height: imageSize)
                case 2:
                    imageView.frame = CGRect(x: imageSize, y: bounds.height - imageSize, width: imageSize, height: imageSize)
                default:
                    break
                }
            default:
                switch index {
                case 0:
                    imageView.frame = CGRect(x: 0, y: 0, width: imageSize, height: imageSize)
                case 1:
                    imageView.frame = CGRect(x: imageSize, y: 0, width: imageSize, height: imageSize)
                case 2:
                    imageView.frame = CGRect(x: 0, y: imageSize, width: imageSize, height: imageSize)
                case 3:
                    imageView.frame = CGRect(x: imageSize, y: imageSize, width: imageSize, height: imageSize)
                default:
                    break
                }
            }
        }
    }
    
}
