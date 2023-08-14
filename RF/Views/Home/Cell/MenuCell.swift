//
//  MenuCell.swift
//  RF
//
//  Created by 용용이 on 2023/08/14.
//

import UIKit


class MenuCell: UICollectionViewCell {
    static let identifier = "MenuCell"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "text"
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    lazy var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        addSubview(underLine)
        
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        underLine.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setColor(textColor: UIColor, backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.label.textColor = textColor
    }
}
