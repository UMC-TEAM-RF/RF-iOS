//
//  InterestingTopicCollectionViewCell.swift
//  RF
//
//  Created by 정호진 on 2023/07/17.
//

import UIKit
import SnapKit

/// MARK: 관심 주제 설정 CollectionView Cell
final class InterestingTopicCollectionViewCell: UICollectionViewCell {
    static let identifier = "InterestingTopicCollectionViewCell"
    
    /// MARK: 관심 주제 라벨
    private lazy var topicLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        addSubview(topicLabel)
        configureConstraints()
    }
    
    
    /// MARK: Set AutoLayout
    private func configureConstraints(){
        topicLabel.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    /// MARK: 연령대 목록 넣기
    func inputData(text: String){
        topicLabel.text = text
    }
 
    /// 글자 색상 변경
    func setColor(color: UIColor){
        topicLabel.textColor = color
    }
    
}
