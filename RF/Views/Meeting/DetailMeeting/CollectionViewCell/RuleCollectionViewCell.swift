//
//  InterestingCollectioViewCell.swift
//  RF
//
//  Created by 정호진 on 2023/07/11.
//

import Foundation
import UIKit
import SnapKit

final class RuleCollectionViewCell: UICollectionViewCell{
    static let identifier = "RuleCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// MARK: 관심사 라벨
    private lazy var ruleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    /// Add UI
    private func addUI(){
        addSubview(ruleLabel)
        
        ruleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    /// inputData
    func inputData(text: String){
        addUI()
        ruleLabel.text = text
    }
    
    func returnRuleLabel() -> UILabel{
        return ruleLabel
    }
    
}
