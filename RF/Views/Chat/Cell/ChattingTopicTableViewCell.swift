//
//  ChattingTopicTableViewCell.swift
//  RF
//
//  Created by 정호진 on 10/13/23.
//

import Foundation
import UIKit
import SnapKit

final class ChattingTopicTableViewCell: UITableViewCell {
    static let identifier = "ChattingTopicTableViewCell"
    
    /// MARK: 제목
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    /// MARK: 옆으로 넘어가는 화살표 이미지
    private lazy var imgview: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "chevron.right")?.withTintColor(.black, renderingMode: .alwaysOriginal))
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        addSubview(titleLabel)
        addSubview(imgview)
        
        constraints()
    }
    
    /// MARK: Set AutoLayout
    private func constraints(){
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        imgview.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    /// MARK: input Data
    func inputData(text: String, imageHidden: Bool){
        titleLabel.text = text
        imgview.isHidden = imageHidden
    }
}
