//
//  InterestingCollectioViewCell.swift
//  RF
//
//  Created by 정호진 on 2023/07/11.
//

import Foundation
import UIKit
import SnapKit

final class InterestingCollectionViewCell: UICollectionViewCell {
    
    /// MARK: 관심사 라벨
    private lazy var interestLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = BackgroundColor.white.color
        label.textAlignment = .center
        return label
    }()
    
    static let identifier = "InterestingCollectioViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    /// Add UI
    private func addUI(){
        addSubview(interestLabel)
        
        interestLabel.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    /// inputData
    func inputData(text: String){
        addUI()
        interestLabel.text = text
    }
    
}
