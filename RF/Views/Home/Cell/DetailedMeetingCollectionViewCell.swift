//
//  DetailedMeetingCollectionViewCell.swift
//  RF
//
//  Created by 용용이 on 2023/08/10.
//

import UIKit


/**
 메인 화면의 모임 리스트의 내용을 보여주는 셀이다. 한 모임당 한 셀이며 imageView, GradientView, UILabel, taglist collectionView 등으로 이루어진 직사각형의 셀이다.
 > 내부적으로 태그 셀 개수를 3개로 잡고 있다. 하위로 TagCollectionViewCell, GradientView 클래스를 사용하고 있다. 해당 클래스들을 변경할 때 이 클래스도 확인해야 한다.
 */
class DetailedMeetingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    /**
     배경 이미지를 담당하는 뷰
     > placeholder로 soccer 사진을 사용.
     */
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "soccer")
        view.contentMode = .scaleToFill
        return view
    }()
    
    /**
     배경 이미지에 그라데이션을 넣는 뷰
     > addFilter로 각 Y위치에 어느 색깔을 넣을지 지정한다.
     */
    private lazy var backgroundMaskedView: GradientView = {
        let view = GradientView()
        view.addFilter( color: UIColor.black.withAlphaComponent(0.06).cgColor, locationY: 0.0)
        view.addFilter( color: UIColor.black.withAlphaComponent(0.36).cgColor, locationY: 0.6)
        view.addFilter( color: UIColor.black.withAlphaComponent(0.72).cgColor, locationY: 1)
        return view
    }()
    
    /**
     모임 제목이 들어가는 레이블
     > Font: 15(Bold), Color : .systemBackground
     */
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "디천: 디자인 천재들 모임"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        label.textColor = ButtonColor.normal.color
        return label
    }()
    
    /**
     모임 설명이 들어가는 레이블
     > Font: 14, Color : .systemBackground
     */
    private lazy var descriptLabel: UILabel = {
        let label = UILabel()
        label.text = "디자인 배우면서 친목하실분~ 디자인 배우면서 친목하실분~ 디자인 배우면서 친목하실분~ 디자인 배우면서 친목하실분~"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = ButtonColor.normal.color
        label.numberOfLines = 2
        return label
    }()
    
    /**
     모임 인원수가 들어가는 레이블
     > Font: 14, Color : .systemBackground
     */
    private lazy var personnelLabel: UILabel = {
        let label = UILabel()
        label.text = "모집 인원 : 2/5"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = ButtonColor.normal.color
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    
    private lazy var likeButton: UICheckBox1 = {
        let button = UICheckBox1()
        
        button.setImage(offimage: UIImage(systemName: "heart")!, onimage: UIImage(systemName: "heart.fill")!)
        button.setScale(offImageResize: 24, onImageResize: 24)
        button.setNormalColor(color: BackgroundColor.white.color)
        button.setSelectedColor(color: .red)
        button.setEventFunction(function: {
            print(self.likeButton.isSelected)
        })
        return button
    }()
    
    /**
     Tag를 보여주는 CollectionView
     > TagCollectionViewCell을 셀으로 잡고 있다.
     */
    private lazy var tagCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        return cv
    }()
    
    // MARK: - Property
    
    static let identifier = "DetailedMeetingCollectionViewCell"
    
    var meetingData: Meeting? {
        didSet {
            setData(meetingData)
        }
    }
    
    // MARK: - init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 10
        //Corner radius 적용을 위한 코드
        contentView.clipsToBounds = true
        
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        //imageView를 제일 아래에, 그 위로 Dimmed View를 추가하기 위해 insert로 적용.
        contentView.insertSubview(backgroundImageView, at: 0)
        contentView.insertSubview(backgroundMaskedView, at: 1)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptLabel)
        contentView.addSubview(personnelLabel)
        contentView.addSubview(likeButton)
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
            make.bottom.equalToSuperview().inset(15)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(descriptLabel.snp.top).offset(-8)
            make.leading.equalToSuperview().inset(15)
        }
        
        personnelLabel.snp.makeConstraints { make in
            make.trailing.equalTo(likeButton.snp.leading).offset(-15)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        likeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-8)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(25)
        }
    }
    
    /**
     cell에 데이터를 입력하는 함수
     > 셀 초기화할 때 사용
     - Parameters:
        - data
    */
    private func setData(_ data : Meeting?){
        
        guard let data = data else { return }
        if let img = URL(string: data.imageFilePath ?? "") {
            backgroundImageView.load(url: img)
        }
        titleLabel.text = data.name
        descriptLabel.text = data.content
        personnelLabel.text = "모임인원: \(data.currentMemberCount ?? 0)/\(data.memberCount ?? 0)"
        tagCollectionView.reloadData()
    }
    
}

// MARK: - Ext: DetailedMeetingCollectionViewCell

extension DetailedMeetingCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //태그 셀 사이즈 설정(폰트 사이즈 14 기준)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let meeting = meetingData else { return CGSize() }
        
        let data = EnumFile.enumfile.enumList.value
        let text = data.interest?.filter{ $0.key  == meeting.interests?[indexPath.item] }.first
        let textSize = text?.value?.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        
        return CGSize(width: (textSize?.width ?? CGFloat()) + 30, height: tagCollectionView.frame.height)
    }
    
    //태그 목록 개수 : 3
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meetingData?.interests?.count ?? 0
    }
    
    //태그 셀 초기화
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
        guard let meeting = meetingData else { return UICollectionViewCell() }
        let data = EnumFile.enumfile.enumList.value
        let text = data.interest?.filter{ $0.key  == meeting.interests?[indexPath.item] ?? "" }.first
        print("text \(text)")
        cell.setupTagLabel(text?.value ?? "")
        return cell
    }
    
}
