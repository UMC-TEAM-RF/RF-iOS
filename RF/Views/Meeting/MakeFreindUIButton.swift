//
//  MakeFreindUIButton.swift
//  RF
//
//  Created by 정호진 on 2023/07/06.
//

import UIKit
import SnapKit

/// MARK: 모임 찾기 및 모임 생성하기 버튼
final class MakeFreindUIButton: UIButton {
    
    /// MARK: 버튼 제목
    private lazy var buttonTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    /// MARK: 첫 번째 설명
    private lazy var firstDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    /// MARK: 두 번째 설명
    private lazy var secondDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    /// MARK: 화살표 이미지
    private lazy var img: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "arrow.right.circle")?.resize(newWidth: 30)
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    /// MARK: add UI
    private func addSubviews(){
        addSubview(buttonTitle)
        addSubview(firstDescription)
        addSubview(secondDescription)
        addSubview(img)
        
        configureConstraints()
    }
    
    /// MARK: setting AutoLayout
    private func configureConstraints(){
        buttonTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        firstDescription.snp.makeConstraints { make in
            make.top.equalTo(buttonTitle.snp.bottom).offset(10)
            make.leading.equalTo(buttonTitle.snp.leading)
        }
        
        secondDescription.snp.makeConstraints { make in
            make.top.equalTo(firstDescription.snp.bottom).offset(10)
            make.leading.equalTo(buttonTitle.snp.leading)
        }
        
        img.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    /// MARK: 데이터 넣는 함수
    func inputData(title: String, description1: String, description2: String){
        addSubviews()
        
        buttonTitle.text = title
        firstDescription.text = description1
        secondDescription.text = description2
    }
}
