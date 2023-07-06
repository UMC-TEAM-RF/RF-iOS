//
//  MettingUIButton.swift
//  RF
//
//  Created by 정호진 on 2023/07/06.
//

import Foundation
import UIKit
import SnapKit

final class MettingUIButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: 아이콘
    private lazy var iconImg: UIImageView = {
        let img = UIImageView()
        
        return img
    }()
    
    // MARK: 제목
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: add UI
    private func addSubviews(){
        addSubview(iconImg)
        addSubview(nameLabel)
            
        configureConstraints()
    }
    
    // MARK: setting AutoLayout
    private func configureConstraints(){
        iconImg.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.top).offset(-5)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func inputData(icon: String, name: String){
        addSubviews()
        iconImg.image = UIImage(systemName: icon)?.resize(newWidth: 20)
        nameLabel.text = name
    }
    
}
