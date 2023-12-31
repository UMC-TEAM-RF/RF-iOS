//
//  MeetingCollectionViewCell.swift
//  RF
//
//  Created by 이정동 on 2023/07/07.
//

import UIKit

class MeetingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "디천: 디자인 천재들 모임"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descriptLabel: UILabel = {
        let label = UILabel()
        label.text = "디자인 배우면서 친목하실분~ 디자인 배우면서 친목하실분~ 디자인 배우면서 친목하실분~ 디자인 배우면서 친목하실분~"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var personnelLabel: UILabel = {
        let label = UILabel()
        label.text = "모집 인원 : 2/5"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var tagCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCollectionViewCell")
        return cv
    }()
    
    // MARK: - Property
    
    static let identifier = "MeetingCollectionViewCell"
    
    var testTagList: [String] = []
    
    // MARK: - init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 10
        
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptLabel)
        contentView.addSubview(personnelLabel)
        contentView.addSubview(tagCollectionView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15)
        }
        
        personnelLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(15)
            make.leading.equalTo(titleLabel.snp.trailing).offset(30)
            make.width.equalTo(100)
        }
        
        descriptLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(descriptLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview().inset(15)
        }
    }
    
    /// 데이터 넣는 함수
    func inputTextData(title: String, description: String, personnel: String, tag: [String]){
        titleLabel.text = title
        descriptLabel.text = description
        personnelLabel.text = personnel
        testTagList = tag
        tagCollectionView.reloadData()
    }
}

// MARK: - Ext: CollectionView

extension MeetingCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: testTagList[indexPath.item].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 30, height: tagCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
        cell.setupTagLabel("#\(testTagList[indexPath.item])")
        return cell
    }
    
    
}
