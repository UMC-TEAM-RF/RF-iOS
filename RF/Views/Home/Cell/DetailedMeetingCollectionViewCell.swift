//
//  DetailedMeetingCollectionViewCell.swift
//  RF
//
//  Created by 용용이 on 2023/08/10.
//

import UIKit





class DetailedMeetingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "soccer")
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var backgroundMaskedView: GradientView = {
        let view = GradientView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "디천: 디자인 천재들 모임"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        label.textColor = .systemBackground
        return label
    }()
    
    private lazy var descriptLabel: UILabel = {
        let label = UILabel()
        label.text = "디자인 배우면서 친목하실분~ 디자인 배우면서 친목하실분~ 디자인 배우면서 친목하실분~ 디자인 배우면서 친목하실분~"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemBackground
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var personnelLabel: UILabel = {
        let label = UILabel()
        label.text = "모집 인원 : 2/5"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemBackground
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
    
    static let identifier = "DetailedMeetingCollectionViewCell"
    
    var testTagList: [String] = []
    
    // MARK: - init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        contentView.insertSubview(backgroundImageView, at: 0)
        contentView.insertSubview(backgroundMaskedView, at: 1)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptLabel)
        contentView.addSubview(personnelLabel)
        contentView.addSubview(tagCollectionView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        
        backgroundMaskedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        
        descriptLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(descriptLabel.snp.top).offset(-8)
            make.leading.equalToSuperview().inset(15)
        }
        
        personnelLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(100)
        }
        
        
        tagCollectionView.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-8)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(25)
        }
    }
    
    /// 데이터 넣는 함수
    func inputTextData(title: String, description: String, personnel: String, tag: [String], imageName: String){
        backgroundImageView.image = UIImage(named: imageName)
        
        titleLabel.text = title
        descriptLabel.text = description
        personnelLabel.text = personnel
        testTagList = tag
        tagCollectionView.reloadData()
    }
}

// MARK: - Ext: CollectionView

extension DetailedMeetingCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: testTagList[indexPath.item].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 30, height: tagCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
        cell.setupTagLabel("#\(testTagList[indexPath.item])")
        return cell
    }
    
    
}



class GradientView: UIView {
    //Background Picture Filter
    let bgdPictureFilter = [UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1).cgColor,UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6).cgColor,UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor]
    let bgdLocations : [NSNumber] = [0.0, 0.4, 1]

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = bgdPictureFilter
        (layer as! CAGradientLayer).locations = bgdLocations
    }
}


