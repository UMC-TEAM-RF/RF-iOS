//
//  SearchingCollectionViewCell.swift
//  RF
//
//  Created by 정호진 on 2023/08/15.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

final class SearchingCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchingCollectionViewCell"
    
    /// MARK: 모임 배경
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    /// MARK: meeting  tag list
    private lazy var tagCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    /// MARK: meeting title Label
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "디천: 디자인 천재들 모임"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 1
        label.textColor = .systemBackground
        return label
    }()
    
    /// MARK: meeting description
    private lazy var descriptLabel: UILabel = {
        let label = UILabel()
        label.text = "디자인 배우면서 친목하실분~ 디자인 배우면서 친목하실분~ 디자인 배우면서 친목하실분~ 디자인 배우면서 친목하실분~"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemBackground
        label.numberOfLines = 2
        return label
    }()
    
    /// meeting join Member Count
    private lazy var personnelLabel: UILabel = {
        let label = UILabel()
        label.text = "모집 인원 : 2/5"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = SearchingCollectionViewCellViewModel()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    // MARK: - Functions
    
    /// MARK: add UI
    private func addSubviews(){
        addSubview(imageView)
        addSubview(tagCollectionView)
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        
        addSubview(titleLabel)
        addSubview(descriptLabel)
        addSubview(personnelLabel)
        
        configureConstraints()
    }
    
    /// MARK: setting AutoLayout
    private func configureConstraints(){
        
        imageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.centerY)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(self.snp.height).multipliedBy(0.1)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(tagCollectionView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        descriptLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        personnelLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(100)
        }
        
        
      
    }
    
    /// 데이터 넣는 함수
    func inputTextData(meeting: Meeting?){
        self.imageView.image = UIImage(named: meeting?.imageFilePath ?? "")
        
        titleLabel.text = meeting?.name ?? ""
        descriptLabel.text = meeting?.content ?? ""
        personnelLabel.text = "모집인원: \(meeting?.users?.count ?? 0)/\(meeting?.memberCount ?? 0)"
        viewModel.tagList.accept(meeting?.rule ?? [])
         tagCollectionView.reloadData()
     }
    
}

extension SearchingCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tagList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
        cell.setupTagLabel(viewModel.tagList.value[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: viewModel.tagList.value[indexPath.item].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 30, height: tagCollectionView.frame.height)
       }
    
}
