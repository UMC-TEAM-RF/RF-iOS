//
//  SelectedButton.swift
//  RF
//
//  Created by 정호진 on 2023/08/05.
//

import Foundation
import UIKit
import SnapKit

/// 학교 및 입학년도 선택하는 버튼
final class SelectedButton: UIButton{
    
    /// MARK: 제목 라벨
    private lazy var title: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .lightGray
        return view
    }()
    
    /// MARK: 이미지 버튼
    private lazy var imgButton: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "chevron.down")?.resize(newWidth: 20)
        return img
    }()
    
    /// MARK: 입학년도 버튼 아래 표시 되는 줄
    private lazy var yearUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - init
    
    /// MARK: Add UI
    private func addSubviews() {
        addSubview(title)
        addSubview(imgButton)
        addSubview(yearUnderLine)
        
        configureConstraints()
    }
    
    
    /// MARK: set AutoLayout
    private func configureConstraints() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(imgButton.snp.leading)
        }
        
        imgButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.width.equalTo(20)
        }
        
        yearUnderLine.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func initText(text: String){
        title.text = text
        title.textColor = .lightGray
    }
    
    /// 데이터 삽입
    func inputData(text: String){
        title.text = text
        title.textColor = .black
    }
}
