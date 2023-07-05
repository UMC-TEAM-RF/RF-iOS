//
//  BannerCollectionViewCell.swift
//  RF
//
//  Created by 이정동 on 2023/07/05.
//

import UIKit
import SnapKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    private lazy var bannerView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubviews() {
        contentView.addSubview(bannerView)
    }
    
    private func configureConstraints() {
        bannerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
