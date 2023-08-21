//
//  MeetingManageUIButton.swift
//  RF
//
//  Created by 정호진 on 2023/08/21.
//

import Foundation
import UIKit
import SnapKit

final class MeetingManageUIButton: UIButton {
    
    
    /// MARK: 이미지
    private lazy var imgView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "list")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    /// MARK:  title
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "모임 일정 관리"
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    /// MARK: add UI
    private func addSubviews(){
        addSubview(imgView)
        addSubview(title)
        configureConstraints()
    }
    
    /// MARK: set AutoLayout
    private func configureConstraints(){
        imgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(title.snp.top).offset(-10)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

    }
    
    /// input Data
    func inputData(img: String, title: String){
        self.title.text = title
        imgView.image = UIImage(named: img)
    }
    
    
}
