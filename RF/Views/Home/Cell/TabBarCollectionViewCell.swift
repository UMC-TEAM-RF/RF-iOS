//
//  TapBarCollectionViewCell.swift
//  RF
//
//  Created by 용용이 on 2023/08/20.
//

import UIKit


/**
 TabBarCollectionView의 셀이다. tabbar 부분(개인 모임, 단체 모임 선택부분)의 셀이다.
 > textLabel 하나만 갖고 있는 단순한 Cell이다. 메서드로는 setTextLabel, setColor 이 두개를 갖고 있다.
 */
class TabBarCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    // MARK: - Property
    
    static let identifier = "TabBarCollectionViewCell"
    
    // MARK: - init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        contentView.addSubview(textLabel)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    /**
     제목을 설정하는 함수
     > 셀 초기화할 때 사용
     - Parameters:
        - _ text : 제목 String
    */
    func setTextLabel(_ text: String) {
        self.textLabel.text = text
    }
    
    /**
     제목 색깔을 설정하는 함수
     > 셀 초기화할 때 사용
     - Parameters:
        - textColor : 글자색 바꾸는 변수
        - backgroundColor : 셀 배경색깔을 바꾸는 변수
    */
    func setColor(textColor: UIColor, backgroundColor: UIColor) {
        self.textLabel.textColor = textColor
        self.contentView.backgroundColor = backgroundColor
    }
}
