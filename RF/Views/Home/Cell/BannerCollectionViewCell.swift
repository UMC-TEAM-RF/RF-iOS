//
//  BannerCollectionViewCell.swift
//  RF
//
//  Created by 이정동 on 2023/07/05.
//

import UIKit
import SnapKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private lazy var bannerView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person")
        view.contentMode = .scaleToFill
        return view
    }()
    
    // MARK: - Property
    static let identifier = "BannerCollectionViewCell"
    
    // MARK: - init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        contentView.addSubview(bannerView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        bannerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setBannerImage(_ image: UIImage?) {
        self.bannerView.image = image
    }
}
