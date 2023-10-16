//
//  ProfileSettingTableViewCell.swift
//  RF
//
//  Created by 용용이 on 2023/10/16.
//

import UIKit

class ProfileSettingTableViewCell: UITableViewCell {
    
    // MARK: - UI Property
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = TextColor.first.color
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    /// MARK: 날짜 바꾸는 버튼
    private lazy var editButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.right")?.resize(newWidth: 14), for: .normal)
        return btn
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
        cv.tag = 0
        return cv
    }()
    
    var personalLifeStyles: [String]? {
        didSet {
            setLifeStyle()
        }
    }
    var personalInterests: [String]? {
        didSet {
            setInterest()
        }
    }
    var personalMBTIs: [String]? {
        didSet {
            setMbti()
        }
    }
    
    // MARK: - Property
    
    static let identifier = "ProfileSettingTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        configureConstraints()
        
        
//        let view = UIView()
//        view.backgroundColor = StrokeColor.sub.color
//        self.selectedBackgroundView = view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        addSubview(label)
        addSubview(editButton)
        addSubview(tagCollectionView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(editButton.snp.leading).offset(20)
        }
        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(label.snp.centerY)
            make.trailing.equalToSuperview().inset(10)
        }
        tagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(25)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func updateTitle(_ txt: String) {
        label.text = txt
    }
    func updateColor(_ color: UIColor) {
        label.textColor = color
    }
    
    /**
     cell에 데이터를 입력하는 함수
     > 셀 초기화할 때 사용
     - Parameters:
        - data
    */
    private func setInterest(){
        tagCollectionView.tag = 1
        tagCollectionView.reloadData()
    }
    
    /**
     cell에 데이터를 입력하는 함수
     > 셀 초기화할 때 사용
     - Parameters:
        - data
    */
    private func setLifeStyle(){
        tagCollectionView.tag = 2
        tagCollectionView.reloadData()
    }
    /**
     cell에 데이터를 입력하는 함수
     > 셀 초기화할 때 사용
     - Parameters:
        - data
    */
    private func setMbti(){
        tagCollectionView.tag = 3
        tagCollectionView.reloadData()
    }
}

// MARK: - Ext: DetailedMeetingCollectionViewCell

extension ProfileSettingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //태그 셀 사이즈 설정(폰트 사이즈 14 기준)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView.tag{
            
        case 1: // interest
            guard let interests = personalInterests else { return CGSize() }
            
            let data = EnumFile.enumfile.enumList.value
            let text = data.interest?.filter{ $0.key  == interests[indexPath.item] }.first
            let textSize = text?.value?.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
            
            return CGSize(width: (textSize?.width ?? CGFloat()) + 30, height: tagCollectionView.frame.height)
            
        case 2: // lifestyle
            guard let lifestyles = personalLifeStyles else { return CGSize() }
            
            let data = EnumFile.enumfile.enumList.value
            let text = data.lifeStyle?.filter{ $0.key  == lifestyles[indexPath.item] }.first
            let textSize = text?.value?.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
            
            return CGSize(width: (textSize?.width ?? CGFloat()) + 30, height: tagCollectionView.frame.height)
            
        case 3: // Mbti
            guard let mbtis = personalMBTIs else { return CGSize() }
            
            let data = EnumFile.enumfile.enumList.value
            let text = data.mbti?.filter{ $0.key  == mbtis[indexPath.item] }.first
            let textSize = text?.value?.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
            
            return CGSize(width: (textSize?.width ?? CGFloat()) + 30, height: tagCollectionView.frame.height)
            
        default:
            return CGSize()
        }
    }
    
    //태그 목록 개수 : 3
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag{
        
        case 1: // interest
            return personalInterests?.count ?? 0
        case 2: // lifestyle
            return personalLifeStyles?.count ?? 0
        case 3: // mbti
            return personalMBTIs?.count ?? 0
        
        default:
            return 0
        }
    }
    
    //태그 셀 초기화
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag{
        
        case 1: // interest
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
            guard let interests = personalInterests else { return UICollectionViewCell() }
            let data = EnumFile.enumfile.enumList.value
            let text = data.interest?.filter{ $0.key  == interests[indexPath.item] }.first
            print("text \(text)")
            cell.setColor(textColor: BackgroundColor.white.color, backgroundColor: ButtonColor.main.color)
            cell.setupTagLabel(text?.value ?? "")
            return cell
            
        case 2: // lifestyle
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
            guard let lifestyles = personalLifeStyles else { return UICollectionViewCell() }
            let data = EnumFile.enumfile.enumList.value
            let text = data.lifeStyle?.filter{ $0.key  == lifestyles[indexPath.item] }.first
            print("text \(text)")
            cell.setColor(textColor: BackgroundColor.white.color, backgroundColor: ButtonColor.main.color)
            cell.setupTagLabel(text?.value ?? "")
            return cell
            
        case 3: // Mbti
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
            guard let mbtis = personalMBTIs else { return UICollectionViewCell() }
            let data = EnumFile.enumfile.enumList.value
            let text = data.mbti?.filter{ $0.key  == mbtis[indexPath.item] }.first
            print("text \(text)")
            cell.setColor(textColor: BackgroundColor.white.color, backgroundColor: ButtonColor.main.color)
            cell.setupTagLabel(text?.value ?? "")
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
}
